//
//  Alarm.swift
//  AlarmiOS22
//
//  Created by Porter Frazier on 10/8/18.
//  Copyright © 2018 BULB. All rights reserved.
//

import Foundation

class Alarm: Equatable, Codable {
    static func == (lhs: Alarm, rhs: Alarm) -> Bool {
        return lhs.name == rhs.name && lhs.fireDate == rhs.fireDate
    }
    
    
    var name: String
    var enabled: Bool
    var uuid: String
    var fireDate: Date
    
    var fireTimeAsString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: fireDate)
    }
    
   init(fireDate: Date, name: String, enabled: Bool = true, uuid: String = UUID().uuidString) {
        
        self.name = name
        self.enabled = enabled
        self.uuid = uuid
        self.fireDate = fireDate
    
    
    }
    
    
    
}
