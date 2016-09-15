//
//  ViewController.swift
//  Accelerometer
//
//  Created by DengYuchi on 9/13/16.
//  Copyright © 2016 LateRain. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    @IBOutlet weak var xValueLabel: UILabel!
    @IBOutlet weak var yValueLabel: UILabel!
    @IBOutlet weak var zValueLabel: UILabel!
    
    @IBOutlet weak var xMinValueLabel: UILabel!
    @IBOutlet weak var xMaxValueLabel: UILabel!
    @IBOutlet weak var yMinValueLabel: UILabel!
    @IBOutlet weak var yMaxValueLabel: UILabel!
    @IBOutlet weak var zMinValueLabel: UILabel!
    @IBOutlet weak var zMaxValueLabel: UILabel!
    
    @IBOutlet weak var gValueLabel: UILabel!
    @IBOutlet weak var maxGValueLabel: UILabel!
    
    @IBOutlet weak var calibrateButton: UIButton!
    @IBOutlet weak var resetDataButton: UIButton!
    
    @IBOutlet weak var gMeterView: GMeterView!
    
    var motionManager: CMMotionManager!
    var numberFormatter: NumberFormatter!
    
    var xMinAcceleration = 0.00
    var xMaxAcceleration = 0.00
    var yMinAcceleration = 0.00
    var yMaxAcceleration = 0.00
    var zMinAcceleration = 0.00
    var zMaxAcceleration = 0.00
    
    var maxAcceleration = 0.00

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateAccelerations()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateAccelerations() {
        motionManager = CMMotionManager()
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        
        let monoSpacedDigitFont = UIFont.monospacedDigitSystemFont(ofSize: 17.0, weight: UIFontWeightMedium)
        xValueLabel.font = monoSpacedDigitFont
        yValueLabel.font = monoSpacedDigitFont
        zValueLabel.font = monoSpacedDigitFont
        gValueLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 54.0, weight: UIFontWeightRegular)
        maxGValueLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 18.0, weight: UIFontWeightBold)
        
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.03
            motionManager.startDeviceMotionUpdates(to: OperationQueue.main, withHandler: { (data, error) in
                if let acceleration = data?.userAcceleration {
                    self.xValueLabel.text = String(format: "%.2lf", acceleration.x.twoDecimalDigitsRounded)
                    self.yValueLabel.text = String(format: "%.2lf", acceleration.y.twoDecimalDigitsRounded)
                    self.zValueLabel.text = String(format: "%.2lf", acceleration.z.twoDecimalDigitsRounded)
                    
                    if (acceleration.x.twoDecimalDigitsRounded < self.xMinAcceleration) {
                        self.xMinAcceleration = acceleration.x.twoDecimalDigitsRounded
                        self.xMinValueLabel.text = String(format: "%.2lf", acceleration.x.twoDecimalDigitsRounded)
                    }
                    if (acceleration.x.twoDecimalDigitsRounded > self.xMaxAcceleration) {
                        self.xMaxAcceleration = acceleration.x.twoDecimalDigitsRounded
                        self.xMaxValueLabel.text = String(format: "%.2lf", acceleration.x.twoDecimalDigitsRounded)
                    }
                    if (acceleration.y.twoDecimalDigitsRounded < self.yMinAcceleration) {
                        self.yMinAcceleration = acceleration.y.twoDecimalDigitsRounded
                        self.yMinValueLabel.text = String(format: "%.2lf", acceleration.y.twoDecimalDigitsRounded)
                    }
                    if (acceleration.y.twoDecimalDigitsRounded > self.yMaxAcceleration) {
                        self.yMaxAcceleration = acceleration.y.twoDecimalDigitsRounded
                        self.yMaxValueLabel.text = String(format: "%.2lf", acceleration.y.twoDecimalDigitsRounded)
                    }
                    if (acceleration.z.twoDecimalDigitsRounded < self.zMinAcceleration) {
                        self.zMinAcceleration = acceleration.z.twoDecimalDigitsRounded
                        self.zMinValueLabel.text = String(format: "%.2lf", acceleration.z.twoDecimalDigitsRounded)
                    }
                    if (acceleration.z.twoDecimalDigitsRounded > self.zMaxAcceleration) {
                        self.zMaxAcceleration = acceleration.z.twoDecimalDigitsRounded
                        self.zMaxValueLabel.text = String(format: "%.2lf", acceleration.z.twoDecimalDigitsRounded)
                    }
                    
                    let overallAcceleration = Helpers.calculateOverallAcceleration(x: acceleration.x, y: acceleration.y, z: acceleration.z)
                    self.gValueLabel.text = String(format: "%.2lf", overallAcceleration)
                    if overallAcceleration > self.maxAcceleration {
                        self.maxAcceleration = overallAcceleration.twoDecimalDigitsRounded
                        self.maxGValueLabel.text = String(format: "%.2lf", overallAcceleration)
                    }
                    
                    self.gMeterView.updateGravityCenter(x: -acceleration.x.twoDecimalDigitsRounded, y: acceleration.z > 0 ? -sqrt(acceleration.y * acceleration.y + acceleration.z * acceleration.z).twoDecimalDigitsRounded : sqrt(acceleration.y * acceleration.y + acceleration.z * acceleration.z).twoDecimalDigitsRounded)
                }
            })
        }
    }
    
    @IBAction func resetDataButtonTapped(_ sender: AnyObject) {
        xMinAcceleration = 0.00
        xMaxAcceleration = 0.00
        yMinAcceleration = 0.00
        yMaxAcceleration = 0.00
        zMinAcceleration = 0.00
        zMaxAcceleration = 0.00
        maxAcceleration = 0.00
        
        xMinValueLabel.text = "0.00"
        xMaxValueLabel.text = "0.00"
        yMinValueLabel.text = "0.00"
        yMaxValueLabel.text = "0.00"
        zMinValueLabel.text = "0.00"
        zMaxValueLabel.text = "0.00"
        maxGValueLabel.text = "0.00"
    }
    
}

