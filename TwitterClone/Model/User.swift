//
//  User.swift
//  TwitterClone
//
//  Created by ibrahim uysal on 28.01.2023.
//

import Foundation
import Firebase

struct User {
    let uid: String
    let username: String
    let fullname: String
    let email: String
    var profileImageUrl: URL?
    
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == uid }
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        
        self.username = dictionary["username"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        
        if let profileImageUrlString = dictionary["profileImageUrl"] as? String {
            guard let url = URL(string: profileImageUrlString) else { return }
            self.profileImageUrl = url
        }
    }
}
