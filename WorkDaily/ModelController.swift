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
    
    enum OrderBy {
        case category
        case service
        case name
        case date
        
        mutating func toggle() {
            switch self {
            case .category:
                self = .service
            case .service:
                self = .name
            case .name:
                self = .date
            case .date:
                self = .category
            }
        }
        
        var description: String {
            switch self {
            case .category:
                return "工作"
            case .date:
                return "日期"
            case .name:
                return "标题"
            case .service:
                return "业务"
            }
        }
        
        var comparation: (Log, Log) -> Bool {
            switch self {
            case .category:
                return { lhs, rhs in
                    return lhs.category.rawValue > rhs.category.rawValue
                }
            case .service:
                return { lhs, rhs in
                    return lhs.service.rawValue > rhs.service.rawValue
                }
            case .name:
                return { lhs, rhs in
                    return lhs.name > rhs.name
                }
            case .date:
                return { lhs, rhs in
                    return lhs.start < rhs.start
                }
            }
        }
    }

    
    private let storageController: StorageController
    var logs: [Log]
    var logsOrder = OrderBy.category
    
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
        logsOrder.toggle()
        logs.sort(by: logsOrder.comparation)
    }
}
