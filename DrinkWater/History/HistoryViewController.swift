//
//  HistoryViewController.swift
//  DrinkWater
//
//  Created by Tatiana Ampilogova on 1/6/20.
//  Copyright © 2020 Tatiana Ampilogova. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let waterService = WaterService()
    let history = WaterService().history()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTable()
        title = loc("history")
    }
    
   private func createTable() {
        let historyTableView = UITableView(frame: view.bounds, style: .plain)
        historyTableView.delegate = self
        historyTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(historyTableView)
        
        let nib = UINib(nibName: HistoryCell.className, bundle: nil)
        historyTableView.register(nib, forCellReuseIdentifier: HistoryCell.className)
        historyTableView.dataSource = self 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryCell.className, for: indexPath) as? HistoryCell else {
            preconditionFailure("HistoryCell can't be dequeued")
        }
        let value = history[indexPath.row].value
        let date = history[indexPath.row].date
        cell.dateLabel?.text = DateHelper.formattedDate(from: date)
        if AppSettingsVolume.unit == .liter {
            cell.valueLabel?.text = VolumeFormatter.string(from: value) + loc("ml")
        } else {
            cell.valueLabel?.text = VolumeFormatter.string(from: value) + loc("fl.oz")
        }
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let viewController = DetailHistoryViewController(date: history[indexPath.row].date)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
