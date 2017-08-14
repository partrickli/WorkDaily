//
//  ViewController.swift
//  WorkDaily
//
//  Created by liguiyan on 2017/8/4.
//  Copyright © 2017年 partrick. All rights reserved.
//

import UIKit

class LogsController: UICollectionViewController {
    
    enum reuseIdentifier: String {
        case logCell
    }
    
    // model
    
    var logs:[Log] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "工作记录"
        
        collectionView?.register(LogCell.self, forCellWithReuseIdentifier: reuseIdentifier.logCell.rawValue)
        
        // Right side bar buttom item for adding new work log

        let newLogBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "add"), style: .done, target: self, action: #selector(addNewLog))
        navigationItem.rightBarButtonItem = newLogBarButton
        
        
        logs.append(Log(name: "不知", start: Date(), end: Date(), category: .support, service: .common))
        
        // directly switch to LogEdiotrController for test 
        addNewLog()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return logs.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier.logCell.rawValue, for: indexPath) as! LogCell
        cell.log = logs[indexPath.item]
        return cell
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
        logs.append(log)
        collectionView?.reloadData()
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

