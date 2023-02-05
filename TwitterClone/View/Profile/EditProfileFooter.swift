//
//  EditProfileFooter.swift
//  TwitterClone
//
//  Created by ibrahim uysal on 5.02.2023.
//

import UIKit

protocol EditProfileFooterDelegate: AnyObject {
    func logoutButtonPressed()
}

class EditProfileFooter: UIView {
    
    //MARK: - Properties
    
    weak var delegate: EditProfileFooterDelegate?
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.addTarget(self, action: #selector(logoutButtonPressed), for: .touchUpInside)
        button.backgroundColor = .systemGroupedBackground
        return button
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(logoutButton)
        logoutButton.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc func logoutButtonPressed() {
        delegate?.logoutButtonPressed()
    }
    
}
