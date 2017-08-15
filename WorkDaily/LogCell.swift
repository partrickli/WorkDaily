//
//  LogCell.swift
//  WorkDaily
//
//  Created by liguiyan on 2017/8/14.
//  Copyright © 2017年 partrick. All rights reserved.
//

import UIKit

class LogCell: UITableViewCell {
    
    var log: Log? {
        didSet {
            nameLabel.text = log?.name
            categoryLabel.text = log?.category.rawValue.spaceFilled
            categoryLabel.backgroundColor = UIColor(category: log?.category ?? .construct)
            serviceLabel.text = log?.service.rawValue.spaceFilled
            serviceLabel.backgroundColor = UIColor(category: log?.category ?? .construct)
            startDateLabel.text = " \(log?.start.formatted ?? "") "
            endDateLabel.text = " \(log?.end.formatted ?? "") "
        }
    }
    
    let nameLabel: UILabel = make { l in
        l.text = "hello world"
        l.font = UIFont.boldSystemFont(ofSize: 24)
        l.textColor = .gray
        l.numberOfLines = 2
    }
    
    
    let startDateLabel: DateLabel = make { l in
        
        let today = Date()
        l.text = "\(today.formatted) "

    }
    
    let endDateLabel: DateLabel = make { l in
        
        let today = Date() + 3600 * 24
        l.text = " " + today.formatted + " "
    }
    
    let categoryLabel: UILabel = make { l in
        l.text = "工作类别"
        l.font = UIFont.boldSystemFont(ofSize: 14)
        l.textColor = .white
        l.backgroundColor = UIColor.dateLabelColor
        l.layer.cornerRadius = 5
        l.layer.masksToBounds = true
    }
    
    let serviceLabel: UILabel = make { l in
        l.text = "业务类型"
        l.font = UIFont.boldSystemFont(ofSize: 14)
        l.textColor = .white
        l.backgroundColor = UIColor.dateLabelColor
        l.layer.cornerRadius = 5
        l.layer.masksToBounds = true
    }

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        
        let dateStackView = UIStackView(arrangedSubviews: [startDateLabel, endDateLabel, categoryLabel])
        dateStackView.axis = .horizontal
        dateStackView.spacing = 10
        dateStackView.distribution = .equalCentering
        
        let tagStackView = UIStackView(arrangedSubviews: [categoryLabel, serviceLabel])
        tagStackView.axis = .horizontal
        tagStackView.spacing = 10
        tagStackView.distribution = .equalSpacing
        tagStackView.alignment = .trailing
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, tagStackView, dateStackView])
        nameLabel.setContentHuggingPriority(255, for: .vertical)
        categoryLabel.setContentHuggingPriority(260, for: .vertical)
        startDateLabel.setContentHuggingPriority(260, for: .vertical)
        endDateLabel.setContentHuggingPriority(260, for: .vertical)
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 10
        let insetWidth: CGFloat = 18
        let stackViewConstraints = [
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: insetWidth),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: insetWidth),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -insetWidth),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insetWidth)
        ]
        NSLayoutConstraint.activate(stackViewConstraints)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
}

class DateLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        font = UIFont.boldSystemFont(ofSize: 16)
        textColor = .white
        backgroundColor = UIColor.dateLabelColor
        layer.cornerRadius = 5
        layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
