//
//  LogHeaderView.swift
//  WorkDaily
//
//  Created by liguiyan on 2017/8/17.
//  Copyright © 2017年 partrick. All rights reserved.
//

import UIKit

class LogHeaderView: UIView {
    
    // model
    
    var logs: [Log]?


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.lightGray
    }
    
    override func draw(_ rect: CGRect) {
        
        
        
        if let logs = logs {
            
            let numberAttributes = [
                NSFontAttributeName: UIFont.boldSystemFont(ofSize: 28),
                NSForegroundColorAttributeName: UIColor.white
            ]
            
            let descriptionAttributes = [
                NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14),
                NSForegroundColorAttributeName: UIColor.white
            ]
            
            // total count
            
            let totalCountString = NSAttributedString(string: " \(logs.count) ", attributes: numberAttributes)
            
            let descriptionString = NSAttributedString(string: "记录", attributes: descriptionAttributes)
            
            // count by category
            
            let categoryCount = logs.reduce(Dictionary<Log.Category, Int>()) { countDict, log in
                var countDict = countDict
                if let count = countDict[log.category] {
                    countDict[log.category] = count + 1
                } else {
                    countDict[log.category] = 1
                }
                return countDict
            }

            let categoryString = categoryCount.reduce(NSMutableAttributedString()) { string, cateCount in
                let count = NSAttributedString(string: " \(cateCount.value) ", attributes: numberAttributes)
                string.append(count)
                let description = NSAttributedString(string: cateCount.key.rawValue, attributes: descriptionAttributes)
                string.append(description)
                return string
            }
            
            
            //
            let headerString = NSMutableAttributedString(attributedString: totalCountString)
            headerString.append(descriptionString)
            headerString.append(categoryString)
            
            headerString.draw(at: CGPoint(x: 20, y: 20))
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




