//
//  NotificationCell.swift
//  TwitterClone
//
//  Created by ibrahim uysal on 3.02.2023.
//

import UIKit

class NotificationCell: UITableViewCell {
    
    //MARK: - Properties

    private lazy var profileImageView: UIImageView = {
       let iv = UIImageView()
        iv.setDimensions(height: 40, width: 40)
        iv.layer.cornerRadius = 40 / 2
        iv.layer.masksToBounds = true
        iv.backgroundColor = .twitterBlue
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(profileImagePressed))
        iv.addGestureRecognizer(tap)
        iv.isUserInteractionEnabled = true
        
        return iv
    }()
    
    let notificationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Some test notification message"
        return label
    }()
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stack = UIStackView(arrangedSubviews: [profileImageView, notificationLabel])
        stack.spacing = 8
        stack.alignment = .center
        
        addSubview(stack)
        stack.centerY(inView: self)
        stack.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: 12, paddingRight: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc func profileImagePressed() {
        
    }
}
