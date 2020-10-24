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
    
    func signInUser(email:String, password:String, completion:@escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func registerUser(email:String, password1:String, userProfileImage:UIImage?, completion:@escaping (Bool, Error?, String?) -> Void) {
        
        
        // 프로필 이미지가 있다면 업로드 해준다.
        if let profileImage = userProfileImage {
            
            Auth.auth().createUser(withEmail: email, password: password1) { (result, error) in
                if let error = error {
                    completion(false, error, "회원가입 실패")
                    return
                }else {
                    guard let user = result?.user else { return }
                    if let data = profileImage.pngData() {
                        let storage = Storage.storage()
                        let storageRef = storage.reference()
                        let profileRef = storageRef.child("\(user.uid).jpg")
                        let uploadTask = profileRef.putData(data, metadata: nil) { (metadata, error) in
                            if let error = error {
                                print("DEBUG: \(error.localizedDescription)")
                                return
                            }else {
                                profileRef.downloadURL { (url, error) in
                                    if let url = url {
                                        let db = Firestore.firestore()
                                        db.collection("users").document(user.uid).setData([
                                            "email":email,
                                            "password": password1,
                                            "profileImage":url.absoluteString
                                        ]) { (error) in
                                            if let error = error {
                                                completion(false, error, "회원가입 실패")
                                                return
                                            }
                                            completion(true, nil, nil)
                                        }
                                }
                            }
                        }
                        
                    }
                        uploadTask.resume()
                    
                }
            }
            
            }
        }
        else {
            Auth.auth().createUser(withEmail: email, password: password1) { (authDataResult, error) in
                if let error = error {
                    
                    completion(false, error, "유저를 생성하는데 실패하였습니다")
                    return
                }else {
                    
                    guard let user = authDataResult?.user else {
                        completion(false, error, "유저를 생성하는데 실패하였습니다")
                        return
                    }
                    let db = Firestore.firestore()
                    db.collection("users").document(user.uid).setData([
                        "email":email,
                        "password":password1
                    ]) { (error) in
                        if let error = error {
                            completion(false, error, "유저를 생성하는데 실패하였습니다")
                            return
                        }else {
                            
                        }
                    }
                    
                }
            }
        }
        
        
    }
}
