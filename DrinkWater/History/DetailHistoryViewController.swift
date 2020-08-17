//
//  DetailHistoryViewController.swift
//  DrinkWater
//
//  Created by Tatiana Ampilogova on 1/10/20.
//  Copyright © 2020 Tatiana Ampilogova. All rights reserved.
//

import UIKit

class DetailHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let waterService = WaterService()
    var detailHistory = [(time: String, value: Double)]()
    var date = String()
    
    init(date: String) {
        super.init(nibName: nil, bundle: nil)
        detailHistory = WaterService().water(at: date)
        self.date = DateHelper.formattedDate(from: date)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Never will happen")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createTable()
        title = date
    }
    
    func createTable() {
        let detailHistoryTableView = UITableView(frame: view.bounds, style: .plain)
        detailHistoryTableView.delegate = self
        detailHistoryTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(detailHistoryTableView)
        
        let nib = UINib(nibName: HistoryCell.className, bundle: nil)
        detailHistoryTableView.register(nib, forCellReuseIdentifier: HistoryCell.className)
        detailHistoryTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        detailHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryCell.className, for: indexPath) as? HistoryCell else {
            preconditionFailure("HistoryCell can't be dequeued")
        }
        let time = detailHistory[indexPath.row].time
        let value = detailHistory[indexPath.row].value
        cell.dateLabel?.text = time
        cell.valueLabel?.text = VolumeFormatter.string(from: value)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

