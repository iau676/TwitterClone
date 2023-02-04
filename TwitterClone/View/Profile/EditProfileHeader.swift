//
//  EditProfileHeader.swift
//  TwitterClone
//
//  Created by ibrahim uysal on 4.02.2023.
//

import UIKit

protocol EditProfileHeaderDelegate: AnyObject {
    func changeProfilePhotoPressed()
}

class EditProfileHeader: UIView {
    
    //MARK: - Properties
    
    private let user: User
    weak var delegate: EditProfileHeaderDelegate?
    
    let profileImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 3.0
        return iv
    }()
    
    private lazy var changePhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Changle Profile Photo", for: .normal)
        button.addTarget(self, action: #selector(changePhotoButtonPressed), for: .touchUpInside)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    //MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(frame: .zero)
        
        backgroundColor = .twitterBlue
        
        addSubview(profileImageView)
        profileImageView.centerX(inView: self)
        profileImageView.centerY(inView: self, constant: -16)
        profileImageView.setDimensions(height: 90, width: 90)
        profileImageView.layer.cornerRadius = 90 / 2
        
        addSubview(changePhotoButton)
        changePhotoButton.centerX(inView: self)
        changePhotoButton.anchor(top: profileImageView.bottomAnchor, paddingTop: 8)
        
        profileImageView.sd_setImage(with: user.profileImageUrl)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc func changePhotoButtonPressed() {
        delegate?.changeProfilePhotoPressed()
    }
    
}
