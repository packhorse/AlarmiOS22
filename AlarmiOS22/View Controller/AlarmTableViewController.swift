//
//  AlarmTableViewController.swift
//  AlarmiOS22
//
//  Created by Porter Frazier on 10/8/18.
//  Copyright © 2018 BULB. All rights reserved.
//

import UIKit

protocol AlarmTableViewCellDelegate: class {
    func alarmWasToggled(sender: AlarmTableViewCell)
}


class AlarmTableViewController: UITableViewController, AlarmTableViewCellDelegate {
    func alarmWasToggled(sender: AlarmTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        let alarm = AlarmController.shared.alarms[indexPath.row]
        AlarmController.shared.toggleEnabled(alarm: alarm)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return AlarmController.shared.alarms.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as? AlarmTableViewCell
        let alarm = AlarmController.shared.alarms[indexPath.row]
        cell?.delegate = self
        cell?.alarm = alarm
        
        
        return cell ?? UITableViewCell()
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let alarm = AlarmController.shared.alarms[indexPath.row]
            AlarmController.shared.deleteAlarm(alarm: alarm)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }
    }
    
    
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let alarm = AlarmController.shared.alarms[indexPath.row]
            let destinationVC = segue.destination as? AlarmDetailTableViewController
            destinationVC?.alarm = alarm
        }
    }
    
    
}
