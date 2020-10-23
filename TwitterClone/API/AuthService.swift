//
//  AuthService.swift
//  TwitterClone
//
//  Created by 신동규 on 2020/10/24.
//

import UIKit
import Firebase

class AuthService {
    static let shared = AuthService()
    
    func registerUser(email:String, password1:String, userProfileImage:UIImage?, completion:@escaping (Bool, Error?, String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password1) { (authDataResult, error) in
            if let error = error {
                
                completion(false, error, "유저를 생성하는데 실패하였습니다")
                return
            }else {
                guard let user = authDataResult?.user else {
                    completion(false, error, "유저를 생성하는데 실패하였습니다.")
                    return
                }
                
                let db = Firestore.firestore()
                var ref:DocumentReference?
                ref = db.collection("users").addDocument(data: [
                        "email": email,
                        "password": password1,
                        "id": user.uid
                    ], completion: { (error) in
                        
                        if let error = error {
                            completion(false, error, "데이터베이스에 유저를 추가하는데 실패하였습니다")
                            return
                        }
                        
                        completion(true, nil, nil)
                        
                        // 프로필 이미지가 있다면 업로드해준다.
                        if let profileImage = userProfileImage {
                            let storage = Storage.storage()
                            let storageRef = storage.reference()
                            let profileRef = storageRef.child(NSUUID().uuidString)
                            if let data = profileImage.pngData() {
                                let uploadTask = profileRef.putData(data, metadata: nil) { (metadata, error) in
                                    if let error = error {
                                        print("DEBUG: \(error.localizedDescription)")
                                        return
                                    }
                                    profileRef.downloadURL { (url, error) in
                                        if let url = url {
                                            ref?.updateData(["profileImage":url.absoluteString])
                                            return
                                        }
                                    }
                                }
                                uploadTask.resume()
                            }
                        }
               
                    })
                
            }
        }
    }
}
