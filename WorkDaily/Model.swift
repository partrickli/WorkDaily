//
//  Model.swift
//  WorkDaily
//
//  Created by liguiyan on 2017/8/5.
//  Copyright © 2017年 partrick. All rights reserved.
//

import Foundation

struct Log {
    
    enum Category: String {
        case construct = "建设"
        case maintanence = "维护"
        case emergency = "抢修"
        case support = "支撑"
        
        static let all: [Log.Category] = [
            .construct,
            .maintanence,
            .emergency,
            .support
        ]
    }
    
    enum Service: String {
        case common = "大众业务"
        case business = "集客业务"
        case special = "专项工程"
        case other = "其他"
        
        static let all: [Log.Service] = [
            .common,
            .business,
            .special,
            .other
        ]
    }
    
    let name: String
    let detailedDescription: String
    let start: Date
    let end: Date
    let category: Category
    let service: Service
}

// convenient initializer
extension Log {
    init() {
        self.name = ""
        self.detailedDescription = ""
        self.start = Date()
        self.end = Date()
        self.category = .construct
        self.service = .common
    }
}

// Equatable
extension Log: Equatable {
    public static func ==(lhs: Log, rhs: Log) -> Bool {
        return lhs.name == rhs.name
            && lhs.detailedDescription == rhs.detailedDescription
            && lhs.start == rhs.start
            && lhs.end == rhs.end
            && lhs.category == rhs.category
    }
}

// Property List

extension Log {
    
    typealias Plist = [String: AnyObject]
    
    var plistRepresentation: Plist {
        return [
            "name": name as AnyObject,
            "detailedDescription": detailedDescription as AnyObject,
            "start": start as AnyObject,
            "end": end as AnyObject,
            "category": category.rawValue as AnyObject,
            "service": service.rawValue as AnyObject
        ]
    }
    
    init(plist: Plist) {
        self.name = plist["name"] as! String
        self.detailedDescription = plist["detailedDescription"] as! String
        self.start = plist["start"] as! Date
        self.end = plist["end"] as! Date
        self.category = Log.Category(rawValue: plist["category"] as! String) ?? .construct
        self.service = Log.Service(rawValue: plist["service"] as! String) ?? .common
    }
}

// Comparable

extension Log.Category: Comparable {
    
    public static func <(lhs: Log.Category, rhs: Log.Category) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }

}

























