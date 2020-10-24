//
//  TweetCell.swift
//  TwitterClone
//
//  Created by 신동규 on 2020/10/24.
//

import UIKit

class TweetCell:UICollectionViewCell {
    
    // MARK: - Properties
    
    var tweet:TweetModel? {
        didSet {
            guard let tweet = self.tweet else { return }
            
            
            
            self.timeAgoLabel.text = timeAgoSince(tweet.createdAt)
            
            self.message.text = tweet.message
            
            UserService.shared.fetchUser(uid: tweet.uid) { (error, user) in
                guard let user = user else { return }
                self.tweetUser = user
            }
        }
    }
    
    
    var tweetUser:UserModel? {
        didSet {
            guard let user = self.tweetUser else { return }
            
            self.username.text = user.email
            
            if let profileUrlString = user.profileImage {
                if let url = URL(string: profileUrlString) {
                    self.profileImageView.sd_setImage(with: url, completed: nil)
                }
            }
            
        }
    }
    
    private lazy var profileImageView:UIImageView = {
        let iv = UIImageView()
        iv.widthAnchor.constraint(equalToConstant: 48).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 48).isActive = true
        iv.layer.cornerRadius = 24
        iv.clipsToBounds = true
        
        return iv
    }()
    
    private lazy var username:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.bold)
        return label
    }()
    
    private lazy var message:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.medium)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var timeAgoLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.systemGray3
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
        return label
    }()
    
    private lazy var commentButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setImage(#imageLiteral(resourceName: "comment").withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: UIControl.State.normal)
        bt.widthAnchor.constraint(equalToConstant: 18).isActive = true
        bt.heightAnchor.constraint(equalToConstant: 18).isActive = true
        bt.tintColor = .white
        return bt
    }()
    
    private lazy var cycleButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setImage(#imageLiteral(resourceName: "retweet").withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: UIControl.State.normal)
        bt.widthAnchor.constraint(equalToConstant: 18).isActive = true
        bt.heightAnchor.constraint(equalToConstant: 18).isActive = true
        bt.tintColor = .white
        return bt
    }()
    
    private lazy var likeButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setImage(#imageLiteral(resourceName: "like").withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: UIControl.State.normal)
        bt.widthAnchor.constraint(equalToConstant: 18).isActive = true
        bt.heightAnchor.constraint(equalToConstant: 18).isActive = true
        bt.tintColor = .white
        return bt
    }()
    
    private lazy var shareButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setImage(#imageLiteral(resourceName: "share").withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: UIControl.State.normal)
        bt.widthAnchor.constraint(equalToConstant: 18).isActive = true
        bt.heightAnchor.constraint(equalToConstant: 18).isActive = true
        bt.tintColor = .white
        return bt
    }()
    
    
    
    
    
    // MARK: - Lifecycles
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)

        backgroundColor = .systemBackground

        addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        
        let usernameAndMessage = UIStackView(arrangedSubviews: [username, message])
        usernameAndMessage.axis = .vertical
        usernameAndMessage.spacing = 8
        
        addSubview(usernameAndMessage)
        usernameAndMessage.translatesAutoresizingMaskIntoConstraints = false
        usernameAndMessage.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        usernameAndMessage.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 9).isActive = true
        usernameAndMessage.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        
        
        addSubview(timeAgoLabel)
        timeAgoLabel.translatesAutoresizingMaskIntoConstraints = false
        timeAgoLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        timeAgoLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        
        let buttons = UIStackView(arrangedSubviews: [commentButton, cycleButton, likeButton, shareButton])
        buttons.axis = .horizontal
        buttons.distribution = .equalSpacing
        addSubview(buttons)
        buttons.translatesAutoresizingMaskIntoConstraints = false
        buttons.topAnchor.constraint(equalTo: usernameAndMessage.bottomAnchor, constant: 40).isActive = true
        buttons.leftAnchor.constraint(equalTo: leftAnchor, constant: 70).isActive = true
        buttons.rightAnchor.constraint(equalTo: rightAnchor, constant: -40).isActive = true
        
    
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    
    
}
