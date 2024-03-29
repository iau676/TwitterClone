//
//  UserService.swift
//  TwitterClone
//
//  Created by ibrahim uysal on 28.01.2023.
//

import UIKit
import Firebase

typealias DatabaseCompletion = ((Error?, DatabaseReference) -> Void)

struct UserService {
    static let shared = UserService()
    
    func fetchUser(uid: String, completion: @escaping(User) -> Void) {
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            let uid = snapshot.key
            let user = User(uid: uid, dictionary: dictionary)
            completion(user)
        }
    }
    
    func fetchUsers(completion: @escaping([User]) -> Void) {
        var users = [User]()
        
        REF_USERS.observe(.childAdded) { snapshot in
            let uid = snapshot.key
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            let user = User(uid: uid, dictionary: dictionary)
            users.append(user)
            completion(users)
        }
    }
    
    func followUser(uid: String, completion: @escaping(DatabaseCompletion)) {
         guard let currenUid = Auth.auth().currentUser?.uid else { return }
        
         REF_USER_FOLLOWING.child(currenUid).updateChildValues([uid : 1]) { err, ref in
             REF_USER_FOLLOWERS.child(uid).updateChildValues([currenUid : 1], withCompletionBlock: completion)
         }
    }
    
    func unfollowUser(uid: String, completion: @escaping(DatabaseCompletion)) {
        guard let currenUid = Auth.auth().currentUser?.uid else { return }
        
        REF_USER_FOLLOWING.child(currenUid).child(uid).removeValue { err, ref in
            REF_USER_FOLLOWERS.child(uid).child(currenUid).removeValue(completionBlock: completion)
        }
    }
    
    func checkIfUserIsFollowed(uid: String, completion: @escaping(Bool)-> Void) {
        guard let currenUid = Auth.auth().currentUser?.uid else { return }
        
        REF_USER_FOLLOWING.child(currenUid).child(uid).observeSingleEvent(of: .value) { snapshot in
            print("DEBUG: Snapshot exists is \(snapshot.exists())")
            completion(snapshot.exists())
        }
    }
    
    func fetchUserStats(uid: String, completion: @escaping(UserRelationStats) -> Void) {
        REF_USER_FOLLOWERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            let followers = snapshot.children.allObjects.count
            
            REF_USER_FOLLOWING.child(uid).observeSingleEvent(of: .value) { snapshot in
                let following = snapshot.children.allObjects.count
                let stats = UserRelationStats(followers: followers, following: following)
                completion(stats)
            }
        }
    }
    
    func updateProfileImage(image: UIImage, completion: @escaping(URL?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.3) else { return }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let filename = NSUUID().uuidString
        let ref = STORAGE_PROFILE_IMAGES.child(filename)
        
        ref.putData(imageData) { meta, error in
            ref.downloadURL { url, error in
                guard let profileImageUrl = url?.absoluteString else { return }
                let values = ["profileImageUrl": profileImageUrl]
                
                REF_USERS.child(uid).updateChildValues(values) { err, ref in
                    completion(url)
                }
            }
        }
    }
    
    func saveUserData(user: User, completion: @escaping(DatabaseCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let values = ["fullname": user.fullname,
                      "username": user.username,
                      "bio": user.bio ?? ""]
        
        REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
    }
}
