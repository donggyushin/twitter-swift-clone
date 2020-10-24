//
//  UserModal.swift
//  TwitterClone
//
//  Created by 신동규 on 2020/10/24.
//

import Foundation

struct UserModel {
    
    let email:String
    let password:String
    var profileImage:String?
    let uid:String
    
    init(uid:String,data:[String:Any]) {
        let email = data["email"] as? String ?? ""
        let password = data["password"] as? String ?? ""
        self.uid = uid
        
        self.email = email
        self.password = password
        
        if let profileImage = data["profileImage"] as? String {
            self.profileImage = profileImage
        }
    }
    
}
