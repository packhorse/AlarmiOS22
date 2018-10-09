//
//  AlarmTableViewCell.swift
//  AlarmiOS22
//
//  Created by Porter Frazier on 10/9/18.
//  Copyright © 2018 BULB. All rights reserved.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {

    var alarm: Alarm? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: AlarmTableViewCellDelegate?
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateViews() {
        guard let alarm = alarm else { return }
        
        nameLabel.text = alarm.name
        timeLabel.text = alarm.fireTimeAsString
        alarmSwitch.isOn = alarm.enabled
    }

    @IBAction func alarmSwitch(_ sender: Any) {
        delegate?.alarmWasToggled(sender: self)
    }
    

}
