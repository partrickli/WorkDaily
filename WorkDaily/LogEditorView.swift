//
//  LogEditorView.swift
//  WorkDaily
//
//  Created by liguiyan on 2017/8/13.
//  Copyright © 2017年 partrick. All rights reserved.
//

import UIKit

class LogEditorView: UIView {
    
    var log: Log? {
        
        get {
            guard let name = nameTextField.text else {
                return nil
            }
            let start = startDatePicker.date
            let end = endDatePicker.date
            let selectedCategry = Log.Category.all[categorySegmentedControll.selectedSegmentIndex]
            let selectedService = Log.Service.all[serviceSegmentedControll.selectedSegmentIndex]
            return Log(name: name, start: start, end: end, category: selectedCategry, service: selectedService)
        }
        
        set {
            nameTextField.text = log?.name
            startDatePicker.date = log?.start ?? Date()
            endDatePicker.date = log?.end ?? Date()
            
            if let index = Log.Service.all.index(of: log?.service ?? .common) {
                serviceSegmentedControll.selectedSegmentIndex = index
            }
            
            if let index = Log.Category.all.index(of: log?.category ?? .construct) {
                categorySegmentedControll.selectedSegmentIndex = index
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        let stackedViews: [UIView] = [
            nameTextField,
            categorySegmentedControll,
            serviceSegmentedControll,
            startDatePicker,
            endDatePicker
        ]
        
        for view in stackedViews {
            stackView.addArrangedSubview(view)
        }
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 20
        stackView.axis = .vertical
        addSubview(stackView)
        
        // Constraints
        let edgeConstant: CGFloat = 20
        let constrains = [
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: edgeConstant),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: edgeConstant),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -edgeConstant),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -edgeConstant)
        ]
        NSLayoutConstraint.activate(constrains)
        
    }
    
    // Sub views
    let stackView: UIStackView = {
        let sv = UIStackView()
        return sv
    }()

    let nameTextField: UITextField = make { tf in
        tf.placeholder = "浮生偷得半日闲"
    }
    
    let categorySegmentedControll: UISegmentedControl = {
        let items = Log.Category.all.map { $0.rawValue }
        let sc = UISegmentedControl(items: items)
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    let serviceSegmentedControll: UISegmentedControl = {
        let items = Log.Service.all.map { $0.rawValue }
        let sc = UISegmentedControl(items: items)
        sc.selectedSegmentIndex = 0
        return sc
    }()

    
    let startDatePicker: UIDatePicker = make { p in
        p.date = Date()
        p.locale = Locale(identifier: "zh_CN")
        
    }
    
    let endDatePicker: UIDatePicker = make { p in
        p.date = Date() + 60 * 60 * 24
        p.locale = Locale(identifier: "zh_CN")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

