//
//  StorageController.swift
//  WorkDaily
//
//  Created by liguiyan on 2017/8/14.
//  Copyright © 2017年 partrick. All rights reserved.
//

import Foundation

class StorageController {
    
    private let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    private var logsURL: URL {
        return documentDirectoryURL
            .appendingPathComponent("Logs")
            .appendingPathExtension("plist")
    }
    
    func save(_ logs: [Log]) {
        let logsPlist = logs.map { $0.plistRepresentation } as NSArray
        logsPlist.write(to: logsURL, atomically: true)
    }
    
    func fetchLogs() -> [Log] {
        guard let logsPlist = NSArray(contentsOf: logsURL) as? Array<[String: AnyObject]> else {
            return []
        }
        return logsPlist.map { Log(plist: $0) }
    }
}


class StateController {
    private let storageController: StorageController
    var logs: [Log]
    
    init(storageController: StorageController) {
        self.storageController = storageController
        self.logs = storageController.fetchLogs()
    }
    
    func add(_ log: Log) {
        logs.append(log)
        storageController.save(logs)
    }
    
    func saveToStorage() {
        storageController.save(logs)
    }
    
    func reorder() {
        logs.sort { lhs, rhs in
            return lhs.category > rhs.category
        }
    }
}
