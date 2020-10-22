//
//  MainTabController.swift
//  TwitterClone
//
//  Created by 신동규 on 2020/10/21.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: - Properties
    private lazy var actionButton:UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        
        
        button.heightAnchor.constraint(equalToConstant: 56).isActive = true
        button.widthAnchor.constraint(equalToConstant: 56).isActive = true
        button.layer.cornerRadius = 28
        button.layer.masksToBounds = false
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(twitButtonTapped), for: UIControl.Event.touchUpInside)
        button.setImage(#imageLiteral(resourceName: "TwitterLogo").withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: UIControl.State.normal)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewControllers()
        configureUI()
    }
    
    // MARK: - Helpers
    
    @objc func twitButtonTapped(sender:UIButton) {
        print("123")
    }
    
    func configureUI() {
        view.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        actionButton.bottomAnchor.constraint(equalTo: tabBar.topAnchor, constant: -24).isActive = true
    }
    
    func configureViewControllers() {
        
        let feed = FeedController()
        let nav1 = UINavigationController(rootViewController: feed)
        nav1.tabBarItem.title = "피드"
        
        let explore = ExploreController()
        let nav2 = UINavigationController(rootViewController: explore)
        nav2.tabBarItem.title = "검색"
        
        let notifications = NotificationsController()
        let nav3 = UINavigationController(rootViewController: notifications)
        nav3.tabBarItem.title = "알림"
        
        
        let conversations = ConversationController()
        let nav4 = UINavigationController(rootViewController: conversations)
        nav4.tabBarItem.title = "대화"
        
        
        
        
        
        
        viewControllers = [nav1, nav2, nav3, nav4]
    }
}
