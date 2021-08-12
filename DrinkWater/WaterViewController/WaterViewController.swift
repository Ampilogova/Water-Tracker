//
//  DrinkingWaterMeteringViewController.swift
//  DrinkWater
//
//  Created by Tatiana Ampilogova on 12/10/19.
//  Copyright © 2019 Tatiana Ampilogova. All rights reserved.
//

import UIKit
import AudioToolbox
import WidgetKit

class WaterViewController: UIViewController {
    
    let waterService = WaterService()
    let mainShapeLayer = CAShapeLayer()
    let secondShapeLayer = CAShapeLayer()
    
    let colorAqua = UIColor(red: 11, green: 231, blue: 251)
    let tealColorAqua = UIColor(red: 191, green: 249, blue: 253)
    
    @IBOutlet var chartView: UIView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var countWater: UILabel!
    @IBOutlet var dateLable: UILabel!
    @IBOutlet var buttonXS: UIButton!
    @IBOutlet var buttonS: UIButton!
    @IBOutlet var buttonM: UIButton!
    @IBOutlet var buttonYourOption: UIButton!
    @IBOutlet var goalAmountButton: UIButton!
    
    @IBOutlet var volumeLabel: UILabel!
    @IBOutlet var ofLabel: UILabel!
    
    @IBOutlet var buttons: [UIButton]!
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateVolumeLabel()
        updateAmountGoal()
        buttonXS.setTitle(Volume.xs.title, for: .normal)
        buttonS.setTitle(Volume.s.title, for: .normal)
        buttonM.setTitle(Volume.m.title, for: .normal)
        ofLabel.text = loc("of")
        if AppSettingsVolume.unit != .liter {
            volumeLabel.text = loc("fl.oz")
        } else {
            volumeLabel.text = loc("ml")
        }
        
        let oldMaxValue = AppSettingsVolume.unit.maxAmount
        reloadCircle(oldMaxValue: oldMaxValue)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dateLable.text = DateHelper.formattedDate(from: waterService.currentDate())
        
        for button in buttons {
            button.makeRounded()
            button.dropShadow()
        }
        createSecondCircle()
<<<<<<< Updated upstream:DrinkWater/Main/WaterViewController.swift
        createMainCircle()
       
=======
        createBaseCircle()
    }
    func createUndoButton() {
        undoButton.makeRounded()
        undoButton.setTitle(loc("undo"), for: .normal)
        undoButton.layer.borderWidth = 1
        undoButton.layer.borderColor = UIColor.aqua.cgColor
>>>>>>> Stashed changes:DrinkWater/WaterViewController/WaterViewController.swift
    }
    
    func createBaseCircle() {
        let bounds = chartView.bounds
        mainShapeLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 100, height: 100)).cgPath
        mainShapeLayer.lineCap = CAShapeLayerLineCap.round
        mainShapeLayer.strokeColor = colorAqua.cgColor
        mainShapeLayer.lineWidth = 30
        mainShapeLayer.fillColor = UIColor.clear.cgColor
        mainShapeLayer.strokeEnd = 0
        chartView.layer.addSublayer(mainShapeLayer)
    }
    
    func createSecondCircle() {
        let bounds = chartView.bounds
        secondShapeLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 100, height: 100)).cgPath
        secondShapeLayer.lineCap = CAShapeLayerLineCap.round
        secondShapeLayer.strokeColor = tealColorAqua.cgColor
        secondShapeLayer.lineWidth = 30
        secondShapeLayer.fillColor = UIColor.clear.cgColor
        secondShapeLayer.strokeEnd = 1
        chartView.layer.addSublayer(secondShapeLayer)
    }
    
    @IBAction func addWater(_ sender: UIButton) {
        var volume: Volume? = nil
        if sender == buttonXS {
            volume = .xs
            handleTap(value: volume?.value ?? 0.0)
        } else if sender == buttonS {
            volume = .s
            handleTap(value: volume?.value ?? 0.0)
        } else if sender == buttonM {
            volume = .m
            handleTap(value: volume?.value ?? 0.0)
        }
        fullCircle(value: volume?.value ?? 0.0)
        waterService.addWater(value: volume?.value ?? 0.0)
        updateVolumeLabel()
        waterService.reloadWidget()
    }
    
    @IBAction func addYourOption(sender: UIButton) {
        showCustomValueAlert(message: loc("insert.your.amount"))
    }
    
    @IBAction func yourOptionGoal(_ sender: UIButton) {
        showCustomGoalAlert(message: loc("insert.your.goal"))
    }
    
    func updateVolumeLabel() {
        let current = waterService.currentWaterAmount()
        countWater.text = VolumeFormatter.string(from: current)
        if AppSettingsVolume.unit != .liter {
            countWater.text = VolumeFormatter.string(from: current)
        } else {
            countWater.text = VolumeFormatter.string(from: current)
        }
    }
    
    func updateAmountGoal() {
<<<<<<< Updated upstream:DrinkWater/Main/WaterViewController.swift
        goalAmountButton.setTitle(VolumeFormatter.string(from: AppSettingsVolume.unit.maxAmount), for: .normal) 
=======
        targerAmountButton.setTitle(VolumeFormatter.string(from: AppSettings.unit.maxAmount), for: .normal)
        
    }
    
    @IBAction func undoAction(_ sender: Any) {
        waterService.undo()
        updateVolumeLabel()
        let previousMaxValue = AppSettings.unit.maxAmount
        reloadCircle(oldMaxValue: previousMaxValue)
>>>>>>> Stashed changes:DrinkWater/WaterViewController/WaterViewController.swift
    }
    
    func showCustomValueAlert(message: String) {
        let showAlert = UIAlertController(title: loc("insert.your.amount"), message: "", preferredStyle: .alert)
        showAlert.addTextField { (textField: UITextField!) in
            textField.placeholder = loc("insert.your.amount")
        }
        let okAction = UIAlertAction(title: loc("confirm.ok"), style: .default) { action in
            let text = showAlert.textFields?.first?.text ?? ""
            self.handleTap(value: Double(text) ?? 0.0)
            self.waterService.addWater(value: Double(text) ?? 0.0)
            self.updateVolumeLabel()
        }
        let cancelAction = UIAlertAction(title: loc("confirm.cancel"), style: .cancel, handler: nil)
        showAlert.addAction(okAction)
        showAlert.addAction(cancelAction)
        present(showAlert, animated: true)
    }
    
    func showCustomGoalAlert(message: String) {
        let showAlert = UIAlertController(title: loc("insert.your.goal"), message: "", preferredStyle: .alert)
        showAlert.addTextField { (textField: UITextField!) in
            textField.placeholder = loc("insert.your.amount")
        }
        let okAction = UIAlertAction(title: loc("confirm.ok"), style: .default) { action in
            let oldMaxValue = AppSettingsVolume.unit.maxAmount
            let text = showAlert.textFields?.first?.text ?? ""
            UnitVolume.customAmount = Double(text) ?? 0.0
            self.updateAmountGoal()
            self.reloadCircle(oldMaxValue: oldMaxValue)
        }
        let cancelAction = UIAlertAction(title: loc("confirm.cancel"), style: .cancel, handler: nil)
        showAlert.addAction(okAction)
        showAlert.addAction(cancelAction)
        present(showAlert, animated: true)
    }
    
    @objc private func handleTap(value: Double) {
        let current = waterService.currentWaterAmount()
        let amount = AppSettingsVolume.unit.maxAmount
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.fromValue = current / amount
        basicAnimation.toValue = (current + value) / amount
        basicAnimation.duration = 2
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        mainShapeLayer.add(basicAnimation, forKey: "basicAnimation")
    }
    
    func reloadCircle(oldMaxValue: Double) {
        let current = waterService.currentWaterAmount()
        let currentMaxAmount = AppSettingsVolume.unit.maxAmount
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.fromValue = current / oldMaxValue
        basicAnimation.toValue = current / currentMaxAmount
        basicAnimation.duration = 0.5
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        mainShapeLayer.add(basicAnimation, forKey: "basicAnimation")
    }
    func fullCircle(value: Double) {
        let currentMaxAmount = AppSettingsVolume.unit.maxAmount
        let currentValue = waterService.currentWaterAmount()
        if currentValue + value >= currentMaxAmount && currentValue < currentMaxAmount {
            for _ in 1...5 {
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            }
        }
    }
}
