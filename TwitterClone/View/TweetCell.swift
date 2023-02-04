//
//  TweetCell.swift
//  TwitterClone
//
//  Created by ibrahim uysal on 29.01.2023.
//

import UIKit
import ActiveLabel

protocol TweetCellDelegate: AnyObject {
    func profileImagePressed(_ cell: TweetCell)
    func replyPressed(_ cell: TweetCell)
    func likePressed(_ cell: TweetCell)
}

class TweetCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    var tweet: Tweet? {
        didSet { configure() }
    }
    
    weak var delegate: TweetCellDelegate?
    
    private lazy var profileImageView: UIImageView = {
       let iv = UIImageView()
        iv.setDimensions(height: 48, width: 48)
        iv.layer.cornerRadius = 48 / 2
        iv.layer.masksToBounds = true
        iv.backgroundColor = .twitterBlue
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(profileImagePressed))
        iv.addGestureRecognizer(tap)
        iv.isUserInteractionEnabled = true
        
        return iv
    }()
    
    private let replyLabel: ActiveLabel = {
        let label = ActiveLabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.mentionColor = .twitterBlue
        return label
    }()
    
    private let captionLabel: ActiveLabel = {
       let label = ActiveLabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        label.mentionColor = .twitterBlue
        label.hashtagColor = .twitterBlue
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
        
        let captionStack = UIStackView(arrangedSubviews: [infoLabel, captionLabel])
        captionStack.axis = .vertical
        captionStack.spacing = 4

        let imageCaptionStack = UIStackView(arrangedSubviews: [profileImageView, captionStack])
        imageCaptionStack.spacing = 12
        imageCaptionStack.alignment = .leading
        
        let stack = UIStackView(arrangedSubviews: [replyLabel, imageCaptionStack])
        stack.axis = .vertical
        stack.spacing = 8
        
        addSubview(stack)
        stack.anchor(top: topAnchor, left: leftAnchor,
                     right: rightAnchor, paddingTop: 4,
                     paddingLeft: 12, paddingRight: 12)
        
        infoLabel.font = UIFont.systemFont(ofSize: 14)
        
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
        
        configureMentionHandler()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc func profileImagePressed() {
        delegate?.profileImagePressed(self)
    }
    
    @objc func commentPressed() {
        delegate?.replyPressed(self)
    }
    
    @objc func retweetPressed() {
        
    }
    
    @objc func likePressed() {
        delegate?.likePressed(self)
    }
    
    @objc func sharePressed() {
        
    }
    
    //MARK: - Helpers
    
    func configure() {
        guard let tweet = tweet else { return }
        let viewModel = TweetViewModel(tweet: tweet)
        captionLabel.text = tweet.caption
        
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        infoLabel.attributedText = viewModel.userInfoText
        
        likeButton.tintColor = viewModel.likeButtonTintColor
        likeButton.setImage(viewModel.likeButtonImage, for: .normal)
        
        replyLabel.isHidden = viewModel.shouldHideReplyLabel
        replyLabel.text = viewModel.replyText
    }
    
    func configureMentionHandler() {
        captionLabel.handleMentionTap { mention in
            print("DEBUG: Go to user profile for \(mention)")
        }
        
        replyLabel.handleMentionTap { mention in
            print("DEBUG: Go to user profile for \(mention)")
        }
    }
}
