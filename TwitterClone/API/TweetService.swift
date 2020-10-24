//
//  TweetService.swift
//  TwitterClone
//
//  Created by 신동규 on 2020/10/24.
//

import Foundation
import Firebase

class TweetService {
    static let shared = TweetService()
    let db = Firestore.firestore()
    
    func fetchTweets(completion:@escaping (Error?, [TweetModel]) -> Void) {
        
        var tweets:[TweetModel] = []
        
        
        
        db.collection("tweets").order(by: "createdAt", descending: true).getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(error, tweets)
                return
            }
            
            guard let documents = querySnapshot?.documents else { return }
            for document in documents {
                let data = document.data()
                
                
                let tweet = TweetModel(tweetId: document.documentID, data: data)
                tweets.append(tweet)
                
                
            }
            completion(nil, tweets)
            return
            
        }
    }
    
    func postTweet(message:String, uid:String, completion:@escaping (Error?) -> Void){
        
        let date = Date()
        
        db.collection("tweets").addDocument(data: [
            "uid":uid,
            "message":message,
            "createdAt":date.timeIntervalSince1970,
            "updatedAt":date.timeIntervalSince1970,
            "likes":0,
            "retweets":0
        ], completion: completion)
        
    }
}
