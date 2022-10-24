//
//  CacheData.swift
//  iOSAvitoIntern
//
//  Created by Григорий Данилюк on 24.10.2022.
//

import Foundation

//MARK: save data as UserDefaults
class CacheData {
    
    let time = 3600
    
    func saveData(_ response: Any, key: String) {
        UserDefaults.standard.set(response, forKey: key)
    }
    
    func timeDate(_ date: Date, key: String) {
        UserDefaults.standard.set(date, forKey: key)
    }
    
    func getData(key: String) -> Data! {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        return data
    }
    
    func killTimerData(key: String) -> Bool {
        guard let date = UserDefaults.standard.object(forKey: key) as? Date else { return true }
        let nowDate = Calendar.current
        
        guard let variance = nowDate.dateComponents([.second], from: date, to: Date()).second else { return true }
        
        return variance > time ? true : false
    }
}
