//
//  TweetCell.swift
//  TwitterClone
//
//  Created by ibrahim uysal on 29.01.2023.
//

import UIKit

class TweetCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    private let profileImageView: UIImageView = {
       let iv = UIImageView()
        iv.setDimensions(height: 48, width: 48)
        iv.layer.cornerRadius = 48 / 2
        iv.layer.masksToBounds = true
        iv.backgroundColor = .twitterBlue
        return iv
    }()
    
    private let captionLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        label.text = "some test caption"
        return label
    }()
    
    private let infoLabel = UILabel()
    
    private lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "comment"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(height: 20, width: 20)
        button.addTarget(self, action: #selector(commentPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var retweetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "retweet"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(height: 20, width: 20)
        button.addTarget(self, action: #selector(retweetPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "like"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(height: 20, width: 20)
        button.addTarget(self, action: #selector(likePressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "share"), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(height: 20, width: 20)
        button.addTarget(self, action: #selector(sharePressed), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor,
                                paddingTop: 8, paddingLeft: 8)
        
        let stack = UIStackView(arrangedSubviews: [infoLabel, captionLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 4
        
        addSubview(stack)
        stack.anchor(top: profileImageView.topAnchor, left: profileImageView.rightAnchor,
                     right: rightAnchor, paddingLeft: 12, paddingRight: 12)
        
        infoLabel.font = UIFont.systemFont(ofSize: 14)
        infoLabel.text = "water lily @water"
        
        let actionStack = UIStackView(arrangedSubviews: [commentButton, retweetButton,
                                                         likeButton, shareButton])
        actionStack.axis = .horizontal
        actionStack.spacing = 72
        
        addSubview(actionStack)
        actionStack.centerX(inView: self)
        actionStack.anchor(bottom: bottomAnchor, paddingBottom: 8)
        
        let underlineView = UIView()
        underlineView.backgroundColor = .systemGroupedBackground
        addSubview(underlineView)
        underlineView.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 1)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc func commentPressed() {
        
    }
    
    @objc func retweetPressed() {
        
    }
    
    @objc func likePressed() {
        
    }
    
    @objc func sharePressed() {
        
    }
    
    //MARK: - Helpers
    
}
