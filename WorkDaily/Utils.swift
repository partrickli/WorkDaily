//
//  Utils.swift
//  WorkDaily
//
//  Created by liguiyan on 2017/8/4.
//  Copyright © 2017年 partrick. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
    
    static let dateLabelColor: UIColor = UIColor(red: 220, green: 220, blue: 220)
    
    static let tableHeaderBackgroundColor = UIColor(red: 250, green: 230, blue: 240)
    
}

extension String {
    var spaceFilled: String {
        return " \(self) "
    }
}

extension UIColor {
    convenience init(category: Log.Category) {
        switch category {
        case .construct:
            self.init(red: 0xFF, green: 0xAB, blue: 0x63)
        case .emergency:
            self.init(red: 0xFF, green: 0xE6, blue: 0x69)
        case .maintanence:
            self.init(red: 0xB0, green: 0xE0, blue: 0x63)
        case .support:
            self.init(red: 0x7E, green: 0xE6, blue: 0xC2)
        }
    }
}

extension UIColor {
    convenience init(service: Log.Service) {
        switch service {
        case .business:
            self.init(red: 0xFF, green: 0xAB, blue: 0x63)
        case .common:
            self.init(red: 0xFF, green: 0xE6, blue: 0x69)
        case .other:
            self.init(red: 0xB0, green: 0xE0, blue: 0x63)
        case .special:
            self.init(red: 0x7E, green: 0xE6, blue: 0xC2)
        }
    }
}


extension Date {
    var formatted: String {
        let formattor = DateFormatter()
        formattor.locale = Locale(identifier: "zh_CN")
        formattor.dateStyle = .short
        formattor.timeStyle = .none
        
        return formattor.string(from: self)
    }
}
