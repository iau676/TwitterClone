//
//  NotificationService.swift
//  TwitterClone
//
//  Created by ibrahim uysal on 3.02.2023.
//

import Foundation
import Firebase

struct NotificationService {
    
    static let shared = NotificationService()
    
    func uploadNotification(user: User,
                            type: NotificationType,
                            tweet: Tweet? = nil) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        var values: [String: Any] = ["timestamp": Int(NSDate().timeIntervalSince1970),
                                     "uid": uid,
                                     "type": type.rawValue]
        
        if let tweet = tweet {
            values["tweetID"] = tweet.tweetID
        }
        
        REF_NOTIFICATIONS.child(user.uid).childByAutoId().updateChildValues(values)
    }
    
    func fetchNotifications(completion: @escaping([Notification]) -> Void) {
        var notifications = [Notification]()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        REF_NOTIFICATIONS.child(uid).observeSingleEvent(of: .value) { snapshot in
            if !snapshot.exists() {
                //user has no notifications
                completion(notifications)
            } else {
                REF_NOTIFICATIONS.child(uid).observe(.childAdded) { snapshot in
                    guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
                    guard let uid = dictionary["uid"] as? String else { return }
                    
                    UserService.shared.fetchUser(uid: uid) { user in
                        let notification = Notification(user: user, dictionary: dictionary)
                        notifications.append(notification)
                        completion(notifications)
                    }
                }
            }
        }
    }
}
