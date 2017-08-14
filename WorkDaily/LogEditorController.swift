//
//  LogEditorController.swift
//  WorkDaily
//
//  Created by liguiyan on 2017/8/4.
//  Copyright © 2017年 partrick. All rights reserved.
//

import UIKit

class LogEditorController: UIViewController {
    
    // model
    
    var log: Log?
    
    // pass data back to previous view controller
    weak var logDelegate: LogEditorControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let doneBarButton = UIBarButtonItem(title: "保存", style: .done, target: self, action: #selector(saveLog))
        navigationItem.rightBarButtonItem = doneBarButton
        
        title = "新记录"
        
        log = Log(name: "hello world!", start: Date(), end: Date(), category: .construct, service: .common)
        
        
    }
    
    override func loadView() {
        let logEditorView = LogEditorView(frame: UIScreen.main.bounds)
        view = logEditorView
    }
    
    func saveLog() {
        if let editorView = view as? LogEditorView,
            let currentLog = editorView.log {
            logDelegate?.save(log: currentLog)
            navigationController?.popViewController(animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

}


// protocol for pass data to other view controller

protocol LogEditorControllerDelegate: AnyObject {
    func save(log: Log)
}


func make<View>(_ config: (_ v: View) -> ()) -> View where View: UIView {
    let v = View()
    config(v)
    return v
}



