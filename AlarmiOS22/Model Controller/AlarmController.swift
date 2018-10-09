//
//  AlarmController.swift
//  AlarmiOS22
//
//  Created by Porter Frazier on 10/8/18.
//  Copyright © 2018 BULB. All rights reserved.
//

import Foundation


class AlarmController {
    
    //SOT or BOX
    var alarms: [Alarm] = []
    //Shared instance or singelton
    static let shared = AlarmController()
    //CRUD
    
    init() {
        alarms = loadFromPersisentStore()
    }
    
    //Create
    func createAlarm (name: String, fireDate: Date, enabled: Bool) {
        let newAlarm = Alarm(fireDate: fireDate, name: name)
        newAlarm.enabled = enabled
        alarms.append(newAlarm)
        saveToPersistentStore()
    }
    
    //Delete
    func deleteAlarm (alarm: Alarm) {
        guard let alarmIndex = AlarmController.shared.alarms.index(of: alarm) else { return }
        alarms.remove(at: alarmIndex)
        saveToPersistentStore()
    }
    
    //Update
    func updateAlarm (alarm: Alarm, name: String, fireDate: Date, enabled: Bool) {
        alarm.name = name
        alarm.fireDate = fireDate
        alarm.enabled = enabled
        saveToPersistentStore()
    }
    
    func toggleEnabled (alarm: Alarm) {
        alarm.enabled = !alarm.enabled
        
       saveToPersistentStore()
    }
    
    //Persistence
    func fileURL() -> URL{
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = path[0]
        let fileName = "alarm.json"
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        return fileURL
    }
    
    func saveToPersistentStore(){
        
        let encoder = JSONEncoder()
        
        do{
            let data = try encoder.encode(alarms)
            try data.write(to: fileURL())
        } catch{
            print("Failed to Save to Persistent Store \(error) \(error.localizedDescription)")
        }
    }
    
    func loadFromPersisentStore() -> [Alarm]{
        let decoder = JSONDecoder()
        
        do{
            let data = try Data(contentsOf: fileURL())
            let alarms = try decoder.decode([Alarm].self, from: data)
            return alarms
        } catch {
            print("Failed to Load from Persistent Store \(error) \(error.localizedDescription)")
        }
        return []
    }
}
    
    //Notification's
    

