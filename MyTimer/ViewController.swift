//
//  ViewController.swift
//  MyTimer
//
//  Created by MBP潤 on 2021/08/18.
//

import UIKit

class ViewController: UIViewController {
    
    var timer : Timer?
    var count : Double = 0
    let settingKey = "timer_value"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let settings = UserDefaults.standard
        settings.register(defaults: [settingKey:10])
    }
    
    @IBOutlet weak var countDownLabel: UILabel!
    
    @IBAction func settingButtonAction(_ sender: Any) {
        stopTimerOrInitialization()
        performSegue(withIdentifier: "goSetting", sender: nil)
    }
    
    @IBAction func startButtonAction(_ sender: Any) {
        if let nowTimer = timer {
            if nowTimer.isValid == false {
                countDownLabel.text = "残り\(displayUpdate())秒"
            } else if nowTimer.isValid == true {
                return
            }
        }
        timer = Timer.scheduledTimer(timeInterval: 0.1,
                                     target: self,
                                     selector: #selector(self.timerInterrupt(_:)),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @IBAction func stopButtonAction(_ sender: Any) {
        stopTimerOrInitialization()
    }
    
    func displayUpdate() -> Double {
        let settings = UserDefaults.standard
        let timerValue = settings.integer(forKey: settingKey)
        let remainCount = Double(timerValue) - count
        countDownLabel.text = "残り\(Float(remainCount))秒"
        return round(remainCount*10)/10
    }
    @objc func timerInterrupt(_ timer:Timer) {
        count += 0.1
        if displayUpdate() <= 0 {
            count = 0
            countDownLabel.text = "残り0秒"
            timer.invalidate()
        }
    }
    func stopTimerOrInitialization() {
        if let nowTimer = timer {
            // もしタイマーが実行中じゃなかったらタイマーの秒数を初期化
            if nowTimer.isValid == false {
                // 初期化
                count = 0
                countDownLabel.text = "残り0秒"
            } else {
                nowTimer.invalidate()
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        count = 0
        _ = displayUpdate()
    }
}

