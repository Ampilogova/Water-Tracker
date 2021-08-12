//
//  DrinkingWaterMeteringViewController.swift
//  DrinkWater
//
//  Created by Tatiana Ampilogova on 12/10/19.
//  Copyright © 2019 Tatiana Ampilogova. All rights reserved.
//

import UIKit
import AudioToolbox

class WaterViewController: UIViewController {
    
    let waterService = WaterService()
    let foregroundCycleLayer = CAShapeLayer()
    let backgroundCycleLayer = CAShapeLayer()
//    let colorAqua = UIColor(red: 11, green: 231, blue: 251)
//    let tealColorAqua = UIColor(red: 191, green: 249, blue: 253)
    
    @IBOutlet var chartView: UIView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var dateLable: UILabel!
    @IBOutlet var buttonXS: UIButton!
    @IBOutlet var buttonS: UIButton!
    @IBOutlet var buttonM: UIButton!
    @IBOutlet var customValueButton: UIButton!
    @IBOutlet var targetAmountButton: UIButton!
    
    @IBOutlet var undoButton: UIButton!
    @IBOutlet var volumeLabel: UILabel!
    @IBOutlet var ofLabel: UILabel!
    
    @IBOutlet var buttons: [UIButton]!
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = loc("hello")
        ofLabel.text = loc("of")
        dateLable.text = DateHelper.formattedDate(from: waterService.currentDate())
        createUndoButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateVolumeLabel()
        updateAmountGoal()
        buttonXS.setTitle(Volume.xs.title, for: .normal)
        buttonS.setTitle(Volume.s.title, for: .normal)
        buttonM.setTitle(Volume.m.title, for: .normal)
        if AppSettings.unit == .liter {
            volumeLabel.text = loc("ml")
        } else {
            volumeLabel.text = loc("fl.oz")
        }
        
        let previousMaxValue = AppSettings.unit.maxAmount
        reloadCircle(oldMaxValue: previousMaxValue)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        dateLable.text = DateHelper.formattedDate(from: waterService.currentDate())
        for button in buttons {
            button.makeRounded()
            button.dropShadow()
        }
        createSecondCircle()
        createMainCircle()
       
    }
    private func createUndoButton() {
        undoButton.makeRounded()
        undoButton.setTitle(loc("undo"), for: .normal)
        undoButton.layer.borderWidth = 1
        undoButton.layer.borderColor = UIColor.aqua.cgColor
    }
    
    func createMainCircle() {
        let bounds = chartView.bounds
        foregroundCycleLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 100, height: 100)).cgPath
        foregroundCycleLayer.lineCap = CAShapeLayerLineCap.round
        foregroundCycleLayer.strokeColor = UIColor.aqua.cgColor
        foregroundCycleLayer.lineWidth = 30
        foregroundCycleLayer.fillColor = UIColor.clear.cgColor
        foregroundCycleLayer.strokeEnd = 0
        chartView.layer.addSublayer(foregroundCycleLayer)
    }
    
    func createSecondCircle() {
        let bounds = chartView.bounds
        backgroundCycleLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 100, height: 100)).cgPath
        backgroundCycleLayer.lineCap = CAShapeLayerLineCap.round
        backgroundCycleLayer.strokeColor = UIColor.tealAqua.cgColor
        backgroundCycleLayer.lineWidth = 30
        backgroundCycleLayer.fillColor = UIColor.clear.cgColor
        backgroundCycleLayer.strokeEnd = 1
        chartView.layer.addSublayer(backgroundCycleLayer)
    }
    
    @IBAction func addWater(_ sender: UIButton) {
        var volume: Volume? = nil
        if sender == buttonXS {
            volume = .xs
        } else if sender == buttonS {
            volume = .s
        } else if sender == buttonM {
            volume = .m
        }
        handleTap(value: volume?.value ?? 0.0)
        fullCircle(value: volume?.value ?? 0.0)
        waterService.addWater(value: volume?.value ?? 0.0)
        updateVolumeLabel()
    }
    
    @IBAction func addYourOption(sender: UIButton) {
        showCustomValueAlert(message: loc("insert.your.amount"))
    }
    
    @IBAction func yourOptionGoal(_ sender: UIButton) {
        showCustomGoalAlert(message: loc("insert.your.goal"))
    }
    
    func updateVolumeLabel() {
        let current = waterService.currentWaterAmount()
        countLabel.text = VolumeFormatter.string(from: current)
        if AppSettings.unit != .liter {
            countLabel.text = VolumeFormatter.string(from: current)
        } else {
            countLabel.text = VolumeFormatter.string(from: current)
        }
    }
    
    func updateAmountGoal() {
        targetAmountButton.setTitle(VolumeFormatter.string(from: AppSettings.unit.maxAmount), for: .normal) 
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
            let oldMaxValue = AppSettings.unit.maxAmount
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
        let amount = AppSettings.unit.maxAmount
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.fromValue = current / amount
        basicAnimation.toValue = (current + value) / amount
        basicAnimation.duration = 2
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        foregroundCycleLayer.add(basicAnimation, forKey: "basicAnimation")
    }
    
    func reloadCircle(oldMaxValue: Double) {
        let current = waterService.currentWaterAmount()
        let currentMaxAmount = AppSettings.unit.maxAmount
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.fromValue = current / oldMaxValue
        basicAnimation.toValue = current / currentMaxAmount
        basicAnimation.duration = 0.5
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        foregroundCycleLayer.add(basicAnimation, forKey: "basicAnimation")
    }
    func fullCircle(value: Double) {
        let currentMaxAmount = AppSettings.unit.maxAmount
        let currentValue = waterService.currentWaterAmount()
        if currentValue + value >= currentMaxAmount && currentValue < currentMaxAmount {
            for _ in 1...5 {
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            }
        }
    }
}
