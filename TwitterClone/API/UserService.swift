//
//  UserService.swift
//  TwitterClone
//
//  Created by 신동규 on 2020/10/24.
//

import Foundation
import Firebase

class UserService {
    static let shared = UserService()
    
    func fetchUser(uid:String, completion:@escaping (Error?, UserModel?) -> Void) {
        let db = Firestore.firestore()
        db.collection("users").document(uid).getDocument { (querySnapshot, err) in
            if let err = err {
                completion(err, nil)
                return
            }else {
                guard let data = querySnapshot!.data() else { return }
                let user = UserModel(uid:uid, data: data)
                completion(nil, user)
                return
            }
        }
    }
}
