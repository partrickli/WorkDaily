//
//  LogEditorView.swift
//  WorkDaily
//
//  Created by liguiyan on 2017/8/13.
//  Copyright © 2017年 partrick. All rights reserved.
//

import UIKit

class LogEditorView: UIView {
    
    // calculated variable tracing subview value
    var log: Log? {
        
        get {
            guard let name = nameTextField.text else {
                return nil
            }
            let detailedDescription = detailedDescriptionTextView.text

            let selectedCategry = Log.Category.all[categorySegmentedControll.selectedSegmentIndex]
            let selectedService = Log.Service.all[serviceSegmentedControll.selectedSegmentIndex]
            let startDate = Date.dateFromString(startDateTextField.text ?? "") ?? Date()
            
            print(startDate)
            let endDate = Date.dateFromString(endDateTextField.text ?? "") ?? Date()

            return Log(
                name: name,
                detailedDescription: detailedDescription ?? "",
                start: startDate,
                end: endDate,
                category: selectedCategry,
                service: selectedService
            )
        }
        
        set {
            nameTextField.text = newValue?.name
            detailedDescriptionTextView.text = newValue?.detailedDescription
            
            if let index = Log.Service.all.index(of: newValue?.service ?? .common) {
                serviceSegmentedControll.selectedSegmentIndex = index
            }
            
            if let index = Log.Category.all.index(of: newValue?.category ?? .construct) {
                categorySegmentedControll.selectedSegmentIndex = index
            }
            
            startDateTextField.text = newValue?.start.formatted
            endDateTextField.text = newValue?.end.formatted
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        
        let startDateStack = UIStackView(arrangedSubviews: [startDateLabel, startDateTextField])
        let endDateStack = UIStackView(arrangedSubviews: [endDateLabel, endDateTextField])
        let stackView = UIStackView(arrangedSubviews: [
            nameTextField,
            detailedDescriptionTextView,
            categorySegmentedControll,
            serviceSegmentedControll,
            startDateStack,
            endDateStack
        ])

        detailedDescriptionTextView.heightAnchor.constraint(equalToConstant: 100)
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 20
        stackView.axis = .vertical
        
        addSubview(stackView)
        
        // Constraints
        let edgeConstant: CGFloat = 30
        let constraints = [
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: edgeConstant),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: edgeConstant),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -edgeConstant)
            //stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -edgeConstant)
        ]
        NSLayoutConstraint.activate(constraints)
        
        // config date text field editing
        startDateTextField.delegate = self
        endDateTextField.delegate = self

    }
    
    // Sub views

    let nameTextField: UITextField = make { tf in
        tf.placeholder = "标题"
    }
    
    let detailedDescriptionTextView: UITextView = {
        let tv = UITextView(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        tv.text = "详细描述"
        tv.isScrollEnabled = false
        return tv
    }()
    
    let startDateTextField: DateTextField = make { tf in
    }
    
    let endDateTextField: DateTextField = make { tf in
        tf.text = (Date() + 24 * 3600).formatted
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

    
    let startDateLabel: UILabel = make { l in
        l.text = "开始时间: "
    }
    
    let endDateLabel: UILabel = make { l in
        let hourLater = Date() + 3600
        l.text = "结束时间: "
    }
    
    let datePicker: UIDatePicker = make { p in
        p.date = Date()
        p.locale = Locale(identifier: "zh_CN")
        p.datePickerMode = .date
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
    
}

extension LogEditorView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        datePicker.addTarget(textField, action: #selector(DateTextField.onDateChange(_:)), for: .valueChanged)
        textField.inputView = datePicker
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        datePicker.removeTarget(textField, action: #selector(DateTextField.onDateChange(_:)), for: .valueChanged)
    }
}

class DateTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        text = Date().formatted
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onDateChange(_ datePicker: UIDatePicker) {
        text = datePicker.date.formatted
    }

}

