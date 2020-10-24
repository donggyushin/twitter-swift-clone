//
//  TweetModel.swift
//  TwitterClone
//
//  Created by 신동규 on 2020/10/24.
//

import Foundation

struct TweetModel {
    var createdAt:Date
    var likes:Int
    var message:String
    var retweets:Int
    var uid:String
    var updatedAt:Date
    let tweetId:String
    
    
    init(tweetId:String, data:[String:Any]) {
        let createdAt = data["createdAt"] as? Double ?? 0
        let likes = data["likes"] as? Int ?? 0
        let message = data["message"] as? String ?? ""
        let retweets = data["retweets"] as? Int ?? 0
        let uid = data["uid"] as? String ?? ""
        let updatedAt = data["updatedAt"] as? Double ?? 0
        
        
        
        self.tweetId = tweetId
        self.createdAt = Date(timeIntervalSince1970: createdAt)
        self.likes = likes
        self.message = message
        self.retweets = retweets
        self.uid = uid
        self.updatedAt = Date(timeIntervalSince1970: updatedAt)
        
    }
}
