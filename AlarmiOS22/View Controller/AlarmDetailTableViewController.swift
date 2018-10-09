//
//  AlarmDetailTableViewController.swift
//  AlarmiOS22
//
//  Created by Porter Frazier on 10/9/18.
//  Copyright © 2018 BULB. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {

    var alarm: Alarm? {
        didSet {
            loadViewIfNeeded()
            self.updateViews()
        }
    }
    
    var alarmIsOn: Bool = true
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var alarmEnabledButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func updateViews() {
        guard let alarm = alarm else { return }
        alarmIsOn = alarm.enabled
        titleTextField.text = alarm.name
        datePicker.date = alarm.fireDate
        setUpAlarmButton()
    }
    
    func setUpAlarmButton() {
        switch alarmIsOn {
        case true:
            alarmEnabledButton.backgroundColor = UIColor.cyan
            alarmEnabledButton.setTitle("ON", for: .normal)
        case false:
            alarmEnabledButton.backgroundColor = UIColor.gray
            alarmEnabledButton.setTitle("OFF", for: .normal)
        }
        
    }
    
    
    @IBAction func alarmEnabledButtonTapped(_ sender: Any) {
        if let alarm = alarm {
            AlarmController.shared.toggleEnabled(alarm: alarm)
            alarmIsOn = alarm.enabled
        }else{
            alarmIsOn = !alarmIsOn
        }
        setUpAlarmButton()
    }
    
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let title = titleTextField.text else { return }
        guard title != "" else { return }
        
        if let alarm = alarm {
            AlarmController.shared.updateAlarm(alarm: alarm, name: title, fireDate: datePicker.date, enabled: alarmIsOn)
        } else {
            AlarmController.shared.createAlarm(name: title, fireDate: datePicker.date, enabled: alarmIsOn)
        }
        self.navigationController?.popViewController(animated: true)
    }
    

  

}
