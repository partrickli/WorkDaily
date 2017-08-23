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
            detailedDescriptionLabel.text = log?.detailedDescription
            categoryLabel.text = log?.category.rawValue.spaceFilled
            categoryLabel.backgroundColor = UIColor(category: log?.category ?? .construct)
            serviceLabel.text = log?.service.rawValue.spaceFilled
            serviceLabel.backgroundColor = UIColor(service: log?.service ?? .business)
            dateLabel.text = " \(log?.start.formatted ?? "")  ->  \(log?.end.formatted ?? "")"
        }
    }
    
    let nameLabel: UILabel = make { l in
        l.text = "hello world"
        l.font = UIFont.preferredFont(forTextStyle: .title2)
        l.numberOfLines = 1
    }
    
    let detailedDescriptionLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.preferredFont(forTextStyle: .body)
        l.textColor = .gray
        return l
    }()
    
    let dateLabel: DateLabel = make { l in
        
        let today = Date()
        l.text = "\(today.formatted) "

    }
    
    let categoryLabel: UILabel = make { l in
        l.text = "工作类别"
        l.font = UIFont.preferredFont(forTextStyle: .caption1)
        l.textColor = .white
        l.backgroundColor = UIColor.dateLabelColor
        l.layer.cornerRadius = 5
        l.layer.masksToBounds = true
    }
    
    let serviceLabel: UILabel = make { l in
        l.text = "业务类型"
        l.font = UIFont.preferredFont(forTextStyle: .caption1)
        l.textColor = .white
        l.backgroundColor = UIColor.dateLabelColor
        l.layer.cornerRadius = 5
        l.layer.masksToBounds = true
    }

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        
        let tagStackView = UIStackView(arrangedSubviews: [nameLabel, categoryLabel, serviceLabel])
        tagStackView.axis = .horizontal
        tagStackView.spacing = 10
        tagStackView.distribution = .equalSpacing
        tagStackView.alignment = .trailing
        nameLabel.setContentHuggingPriority(255, for: .horizontal)
        categoryLabel.setContentHuggingPriority(260, for: .horizontal)
        serviceLabel.setContentHuggingPriority(260, for: .horizontal)
        
        let stackView = UIStackView(arrangedSubviews: [tagStackView, detailedDescriptionLabel, dateLabel])
        categoryLabel.setContentHuggingPriority(260, for: .vertical)
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
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
        
        font = UIFont.preferredFont(forTextStyle: .footnote)
        textColor = .lightGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
