//
//  VolumeSettingViewController.swift
//  DrinkWater
//
//  Created by Tatiana Ampilogova on 1/16/20.
//  Copyright © 2020 Tatiana Ampilogova. All rights reserved.
//

import UIKit

class VolumeSettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var waterServiceController = WaterService()
    let waterView = WaterViewController()
    var units = [
        Setting(name: loc("ounces")),
        Setting(name: loc("liter"))
    ]
    var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTable()
        title = loc("volume")
    }
    
    func createTable() {
        let settingTableView = UITableView(frame: view.bounds, style: .plain)
        tableView = settingTableView
        settingTableView.delegate = self
        settingTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(settingTableView)
        
        let nib = UINib(nibName: SettingsCell.className, bundle: nil)
        settingTableView.register(nib, forCellReuseIdentifier: SettingsCell.className)
        settingTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        units.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.className, for: indexPath) as? SettingsCell else {
            preconditionFailure("SettingsCell can't be dequeued")
        }
        let setting = units[indexPath.row].name
        cell.nameSettingLabel?.text = setting
        if AppSettings.unit == .ounces && indexPath.row == 0 {
            cell.accessoryType = .checkmark
        } else if AppSettings.unit == .liter && indexPath.row == 1 {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        waterServiceController.reloadWidget()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 && AppSettings.unit != .ounces {
            if waterServiceController.isEmpty() {
                AppSettings.unit = .ounces
            } else {
                showCustomValueAlert(targetUnit: .ounces)
            }
        } else if indexPath.row == 1 && AppSettings.unit != .liter {
            if waterServiceController.isEmpty() {
                AppSettings.unit = .liter
            } else {
                showCustomValueAlert(targetUnit: .liter)
            }
        }
         tableView.reloadData()
    }
    
    func showCustomValueAlert(targetUnit: UnitVolume) {
        let showAlert = UIAlertController(title: loc("alarm"), message: loc("notification.remove.info"), preferredStyle: .alert)
        let okAction = UIAlertAction(title: loc("confirm.ok"), style: .default) { action in
            AppSettings.unit = targetUnit
            self.waterServiceController.remove()
            self.tableView?.reloadData()
        }
        let cancelAction = UIAlertAction(title: loc("confirm.cancel"), style: .cancel, handler: nil)
        
        showAlert.addAction(okAction)
        showAlert.addAction(cancelAction)
        present(showAlert, animated: true)
    }
}
