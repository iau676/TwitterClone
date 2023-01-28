//
//  UserService.swift
//  TwitterClone
//
//  Created by ibrahim uysal on 28.01.2023.
//

import Foundation
import Firebase

struct UserService {
    static let shared = UserService()
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        print("DEBUG: Current uid is \(uid)")
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            let user = User(dictionary: dictionary)
            print("DEBUG: Username is \(user.username)")
        }
    }
}
