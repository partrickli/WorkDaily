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
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            stateController?.logs.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    // adding new work log
    func addNewLog() {
        let logEditorController = LogEditorController()
        logEditorController.logDelegate = self
        navigationController?.pushViewController(logEditorController, animated: true)
    }
    
    
}

extension LogsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: 200)
    }
}


extension LogsController: LogEditorControllerDelegate {
    func save(log: Log) {
        stateController?.add(log)
        tableView?.reloadData()
    }

}

extension Date {
    var formatted: String {
        let formattor = DateFormatter()
        formattor.locale = Locale(identifier: "zh_CN")
        formattor.dateStyle = .short
        formattor.timeStyle = .short
        
        return formattor.string(from: self)
    }
}

