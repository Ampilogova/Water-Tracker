//
//  SettingsViewController.swift
//  DrinkWater
//
//  Created by Tatiana Ampilogova on 1/16/20.
//  Copyright © 2020 Tatiana Ampilogova. All rights reserved.
//

import UIKit
import MessageUI

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {
    
    let settings = [
        Setting(name: loc("volume")),
        Setting(name: loc("notifications")),
        Setting(name: loc("send.feedback")),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = loc("settings")
        createTable()
    }
    
    func createTable() {
        let settingTableView = UITableView(frame: view.bounds, style: .plain)
        settingTableView.delegate = self
        settingTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(settingTableView)
        
        let nib = UINib(nibName: SettingsCell.className, bundle: nil)
        settingTableView.register(nib, forCellReuseIdentifier: SettingsCell.className)
        settingTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.className, for: indexPath) as? SettingsCell else {
            preconditionFailure("SettingsCell can't be dequeued")
        }
        let setting = settings[indexPath.row].name
        cell.nameSettingLabel?.text = setting
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var viewController = UIViewController()
        if indexPath.row == 0 {
            viewController = VolumeSettingViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        } else if indexPath.row == 2 {
            showMailComposer()
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func showMailComposer() {
        guard MFMailComposeViewController.canSendMail() else {
            print("Mail services are not available")
            return
        }
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setCcRecipients(["XXX@gmail.com"])
        composer.setSubject("Drink Water feedback")
        composer.setMessageBody("Hi!", isHTML: false)
        
        self.present(composer, animated: true)
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
