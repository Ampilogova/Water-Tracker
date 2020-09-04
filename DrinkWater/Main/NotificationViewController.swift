// Под этот контроллер и TimeCell лучше создать отдельную папку

//
//  NotificationViewController.swift
//  DrinkWater
//
//  Created by Tatiana Ampilogova on 8/20/20.
//  Copyright © 2020 Tatiana Ampilogova. All rights reserved.
//

import UIKit

// было бы здорово унести работу с User defaults в notificationService
// Еще я понял что хранить индексы в UserDefaults далеко не лучшая идея. Вдруг в будущем ты захочешь скрыть ночные часы например. Поскольку мы переделали timeData на 24-х часовой формат, то идеальным вариантом теперь будет хранить прямо эти строки в UserDefaults. Тогда метод convertTimeNotification будет вообще не нужен. timeSet будет содержать не индексы выбранных ячеек, а значения, например "5:00", "17:00", "6:00"
// Это очень важный момент.


class NotificationViewController: UIViewController, UICollectionViewDelegate {
    
    let userDefaults = UserDefaults.standard
    let notificationService = NotificationService()
    
    var timeSet = Set<Int>()
    let timeData = ["00:00", "12:00", "1:00", "13:00","2:00", "14:00", "3:00", "15:00", "4:00", "16:00", "5:00", "17:00", "6:00", "18:00", "7:00", "19:00", "8:00", "20:00", "9:00", "21:00", "10:00", "22:00", "11:00", "23:00"] // times
    
    
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCollectionView()
        
        let arraySelectTime = UserDefaults.standard.value(forKey: "Notification") as? [Int] // arraySelectTime -> selectedTimes, Notification -> NotificationsTimes
        timeSet = Set(arraySelectTime ?? [])
        
    }
    
    func createCollectionView() {
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        collectionView.register(UINib(nibName: TimeCell.className, bundle: nil), forCellWithReuseIdentifier: "MyCell") // MyCell -> TimeCell.className
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        // лишние переносы строк
        
        view.addSubview(collectionView)
        collectionView.pinToSuperview()
    }
}

// думаю можно объеденить с основным классом, т.е удалить extension
extension NotificationViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width / 2, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return timeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as? TimeCell // MyCell -> TimeCell.className
            else {
                preconditionFailure("TimeCell can't be dequeued")
        }
        
        let time = timeData[indexPath.row]
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "HH:mm"
        let date = dateFormatter.date(from: time) ?? Date()
        let dateFormatter2 = DateFormatter() //dateFormatter2 - не лучшее название
        dateFormatter2.timeStyle = .short
        let date1 = dateFormatter2.string(from: date)
        
        cell.timeLabel?.text = date1
        if timeSet.contains(indexPath.row) {
            cell.selectionView.backgroundColor = UIColor(red: 11, green: 231, blue: 251) // унести в категорию цветов
        } else {
            cell.selectionView.backgroundColor = nil
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !timeSet.contains(indexPath.row) {
            timeSet.insert(indexPath.row)
        } else {
            timeSet.remove(indexPath.row)
        }
        selectionTimeNotification()
        convertTimeNotification()
        collectionView.reloadData()
    }
    
    func selectionTimeNotification() {
        let array = Array(timeSet)
        userDefaults.set(array, forKey: "Notification") // Notification -> NotificationsTimes, я лучше создать константу для этой строки
    }
    
    func convertTimeNotification() {
        var arrayTime = [Int]()
        for index in timeSet {
            let components = (timeData[index]).split { $0 == ":" } .map { (x) -> Int in return Int(String(x))! } // слишком сложно написано и force unwrapp
            // думая можно сократить до: let components = timeData[index].components(separatedBy:":").compactMap({Int($0)})
            
            let hours = components[0]
            arrayTime.append(hours)
        }
        print(arrayTime) // ненужный принт
        notificationService.notificationsScheduler(hours: arrayTime)
    }
}
