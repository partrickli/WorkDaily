//
//  LogDetailController.swift
//  WorkDaily
//
//  Created by liguiyan on 2017/8/20.
//  Copyright © 2017年 partrick. All rights reserved.
//

import UIKit

class LogDetailController: UIViewController {
    
    // model
    
    var log: Log!
    
    override func loadView() {
        view = LogDetailView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        
        title = "当前记录"
        
        if let logDetailedView = view as? LogDetailView {
            logDetailedView.log = log
        }
        
        let editBarButton = UIBarButtonItem(title: "修改", style: .plain, target: self, action: #selector(editCurrentLog))
        
        navigationItem.rightBarButtonItem = editBarButton
    }
    
    // bar button
    func editCurrentLog() {
        print("edit: \n \(log)")
    }
}
