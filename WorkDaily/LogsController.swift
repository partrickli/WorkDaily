//
//  ViewController.swift
//  WorkDaily
//
//  Created by liguiyan on 2017/8/4.
//  Copyright © 2017年 partrick. All rights reserved.
//

import UIKit

class LogsController: UITableViewController {
    
    enum reuseIdentifier: String {
        case logCell
    }
    
    // model
    
    var stateController: StateController?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "工作记录"
        
        tableView.register(LogCell.self, forCellReuseIdentifier: reuseIdentifier.logCell.rawValue)
        
        // Right side bar buttom item for adding new work log

        let newLogBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "add"), style: .done, target: self, action: #selector(addNewLog))
        navigationItem.rightBarButtonItem = newLogBarButton
        
        // Auto resize table view cell height
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // auto open add for test convenience
//        addNewLog()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    
    // Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stateController?.logs.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier.logCell.rawValue, for: indexPath) as! LogCell
        cell.log = stateController?.logs[indexPath.item]
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let logs = stateController?.logs else {
            return UIView()
        }
        
        let headerView = LogHeaderView(frame: .zero)
        headerView.logs = logs
        return headerView
        
    }
    
    // Table view delegate
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            stateController?.logs.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let selectedLog = stateController?.logs[indexPath.row] {
            let logDetailController = LogDetailController()
            logDetailController.log = selectedLog
            logDetailController.indexPath = indexPath
            logDetailController.stateController = stateController
            navigationController?.pushViewController(logDetailController, animated: true)
        }

    }
    
    // adding new work log
    func addNewLog() {
        let logEditorController = LogEditorController()
        logEditorController.logDelegate = self
        navigationController?.pushViewController(logEditorController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
}

extension LogsController: LogEditorControllerDelegate {
    func save(log: Log) {
        stateController?.add(log)
        tableView?.reloadData()
    }

}


