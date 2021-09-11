//
//  ViewController.swift
//  MyTimer
//
//  Created by MBP潤 on 2021/08/18.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet weak var countDownLabel: UILabel!
    
    private var timer: Timer = Timer()
    private var count: Double = 0.0
    private let settingKey: String = "timer_value"
    private let settings = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settings.register(defaults: [settingKey:10])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        count = 0.0
        _ = displayUpdate()
    }
    
    @IBAction func settingButtonAction(_ sender: Any) {
        stopTimerOrInitialization()
        performSegue(withIdentifier: "goSetting", sender: nil)
    }
    
    @IBAction func startButtonAction(_ sender: Any) {
        guard !timer.isValid else { return }

        countDownLabel.text = "残り\(displayUpdate())秒"
        
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
        let timerValue = settings.integer(forKey: settingKey)
        let remainCount = Double(timerValue) - count
        countDownLabel.text = "残り\(Float(remainCount))秒"
        return round(remainCount*10)/10
    }
    
    @objc func timerInterrupt(_ timer:Timer) {
        count += 0.1
        if displayUpdate() <= 0 {
            count = 0.0
            countDownLabel.text = "残り0秒"
            timer.invalidate()
        }
    }
    
    func stopTimerOrInitialization() {
        if !timer.isValid {
            // 初期化
            count = 0.0
            countDownLabel.text = "残り0秒"
        } else {
            timer.invalidate()
        }
    }
}

