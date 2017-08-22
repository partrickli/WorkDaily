//
//  LogDetailView.swift
//  WorkDaily
//
//  Created by liguiyan on 2017/8/20.
//  Copyright © 2017年 partrick. All rights reserved.
//

import UIKit

class LogDetailView: UIView {
    
    var log: Log! {
        didSet {
            nameLabel.text = log.name
            detailedDescriptionLabel.text = log.detailedDescription
            dateView.start = log.start
            dateView.end = log.end

            tagLabel.text = [log.service.rawValue, log.category.rawValue].joined(separator: " ")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        // sub view configuration
        let stackView = UIStackView(arrangedSubviews: [
            nameLabel,
            detailedDescriptionLabel,
            dateView,
            tagLabel
        ])
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 30

        addSubview(stackView)
        
        let customConstraints = [
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            dateView.heightAnchor.constraint(equalToConstant: 20),
            dateView.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ]
        NSLayoutConstraint.activate(customConstraints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // subviews
    
    let nameLabel: UILabel = {
        let l = UILabel()
        l.text = "标题"
        l.font = UIFont.preferredFont(forTextStyle: .title1)
        l.textColor = .black
        l.textAlignment = .center
        return l
    }()

    
    let detailedDescriptionLabel: UILabel = {
        let l = UILabel()
        l.text = "详细描述"
        l.font = UIFont.preferredFont(forTextStyle: .body)
        l.numberOfLines = 0
        l.textColor = .gray
        return l
    }()
    
    let tagLabel: UILabel = {
        let l = UILabel()
        l.text = "tag"
        l.font = UIFont.preferredFont(forTextStyle: .caption2)
        return l
    }()
    
    let dateView: DateView = {
        let v = DateView(start: Date(), end: Date())
        return v
    }()
}


class DateView: UIView {
    
    var start: Date
    var end: Date
    
    init(start: Date, end: Date) {
        self.start = start
        self.end = end
        
        super.init(frame: .zero)
        
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        let dateAttributes = [
            NSFontAttributeName: UIFont.preferredFont(forTextStyle: .caption1),
            NSForegroundColorAttributeName: UIColor.lightGray
        ]
        
        let connectorAttributes = [
            NSFontAttributeName: UIFont.systemFont(ofSize: 12),
            NSForegroundColorAttributeName: UIColor.gray
        ]

        
        let attributedString = NSMutableAttributedString(string: start.formatted, attributes: dateAttributes)
        
        let connector = NSAttributedString(string: " -> ", attributes: connectorAttributes
        )
        
        let endDate = NSAttributedString(string: end.formatted, attributes: dateAttributes)
        attributedString.append(connector)
        attributedString.append(endDate)
        attributedString.draw(at: .zero)
    }
}

































