//
//  ProfileHeader.swift
//  TwitterClone
//
//  Created by ibrahim uysal on 30.01.2023.
//

import UIKit

class ProfileHeader: UICollectionReusableView {
    //MARK: - Properties
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
