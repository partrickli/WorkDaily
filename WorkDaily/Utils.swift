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
            self.init(red: 120, green: 230, blue: 130)
        case .emergency:
            self.init(red: 80, green: 30, blue: 100)
        case .maintanence:
            self.init(red: 50, green: 120, blue: 230)
        case .support:
            self.init(red: 50, green: 90, blue: 87)
        }
    }
}
