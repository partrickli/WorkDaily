//
//  LogCell.swift
//  WorkDaily
//
//  Created by liguiyan on 2017/8/14.
//  Copyright © 2017年 partrick. All rights reserved.
//

import UIKit

class LogCell: UICollectionViewCell {
    
    var log: Log? {
        didSet {
            nameLabel.text = log?.name
        }
    }
    
    let nameLabel: UILabel = make { l in
        l.text = "hello world"
        l.font = UIFont.boldSystemFont(ofSize: 24)
        l.textColor = .gray
    }
    
    
    let startDateLabel: UILabel = make { l in
        
        let today = Date()
        l.text = " " + today.formatted + " "
        l.font = UIFont.boldSystemFont(ofSize: 14)
        l.textColor = .white
        l.backgroundColor = UIColor.dateLabelColor
        l.layer.cornerRadius = 5
        l.layer.masksToBounds = true
    }
    
    let endDateLabel: UILabel = make { l in
        
        let today = Date() + 3600 * 24
        l.text = " " + today.formatted + " "
        l.font = UIFont.boldSystemFont(ofSize: 14)
        l.textColor = .white
        l.backgroundColor = UIColor.dateLabelColor
        l.layer.cornerRadius = 5
        l.layer.masksToBounds = true
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        let dateStackView = UIStackView(arrangedSubviews: [startDateLabel, endDateLabel])
        dateStackView.axis = .horizontal
        dateStackView.spacing = 10
        dateStackView.distribution = .equalCentering
        let stackView = UIStackView(arrangedSubviews: [nameLabel, dateStackView])
        nameLabel.setContentHuggingPriority(255, for: .vertical)
        startDateLabel.setContentHuggingPriority(260, for: .vertical)
        endDateLabel.setContentHuggingPriority(260, for: .vertical)
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 5
        let stackViewConstraints = [
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(stackViewConstraints)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
    }
    
}
