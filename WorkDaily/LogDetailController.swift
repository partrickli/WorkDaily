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
    var stateController: StateController!
    
    var log: Log!
    
    var indexPath: IndexPath!
    
    override func loadView() {
        view = LogDetailView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        
        title = "当前记录"
        
        if let logDetailedView = view as? LogDetailView {
            logDetailedView.log = log
        }
        
        let editBarButton = UIBarButtonItem(title: "修改", style: .plain, target: self, action: #selector(editLog))
        
        navigationItem.rightBarButtonItem = editBarButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let logDetailedView = view as? LogDetailView {
            logDetailedView.log = log
        }
    }
    
    // bar button
    @objc func editLog() {
        let logEditorController = LogEditorController()
        logEditorController.log = log
        logEditorController.logDelegate = self
        navigationController?.pushViewController(logEditorController, animated: true)
    }
    
}

extension LogDetailController: LogEditorControllerDelegate {
    func save(log: Log) {
        self.log = log
        stateController.logs[indexPath.row] = log
        stateController.saveToStorage()
    }
    
}
