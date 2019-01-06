//
//  UserDefaultsTaskRepository.swift
//  ReSports
//
//  Created by 志波大輝 on 2019/01/05.
//  Copyright © 2019 志波大輝. All rights reserved.
//

import Foundation

class UserDefaultsTaskRepository: TaskRepositoryProtocol {
    
    let userDefaults = UserDefaults.standard
    
    func save(_ tasks: [Event], completion: (() -> Void)) {
        // シリアル化
        do {
            let data = try PropertyListEncoder().encode(tasks)
            // UserDefaultsにtasksという名前で保存
            userDefaults.set(data, forKey: "tasks")
        } catch {
            fatalError ("Save Faild.")
        }
        // UserDefaultsは特に非同期ではないので普通にcomletionを実行しています
        completion()
    }
    
    func load(completion: (([Event]) -> Void)) {
        var tasks: [Event] = [];
        if let data = userDefaults.data(forKey: "events") {
            do {
                tasks = try PropertyListDecoder().decode([Event].self, from: data)
            } catch {
                fatalError ("Cannot Load.")
            }
        }
        // UserDefaultsは特に非同期ではないので普通にcomletionを実行しています
        completion(tasks)
    }
}
