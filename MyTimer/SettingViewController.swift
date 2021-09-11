//
//  SettingViewController.swift
//  MyTimer
//
//  Created by MBP潤 on 2021/08/20.
//

import UIKit

class SettingViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var timeSettingPicker: UIPickerView!
    
    private let UserDefSettings = UserDefaults.standard
    private var settingArray: [Int] {
        var arr:[Int] = []

        for i in 0 ... 100 {
            arr.append(i)
        }
        return arr
    }
    private let settingKey = "timer_value"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        timeSettingPicker.delegate = self
        timeSettingPicker.dataSource = self
        
        for row in 0..<settingArray.count {
            if settingArray[row] == UserDefSettings.integer(forKey: settingKey) {
                timeSettingPicker.selectRow(row,
                                            inComponent: 0,
                                            animated: true)
            }
        }
    }
    
    @IBAction func decisionButtonAction(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
        
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return settingArray.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(settingArray[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){

        UserDefSettings.setValue(settingArray[row], forKey: settingKey)
    }
    
}


