//
//  MainTabController.swift
//  TwitterClone
//
//  Created by 신동규 on 2020/10/21.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController {
    
    // MARK: - Properties
    private var user:UserModel? {
        didSet{
            guard let user = self.user else { return }
            print("DEBUG: user is \(user)")
            configureViewControllers(user: user)
        }
    }
    
    
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
        
        view.backgroundColor = .systemBackground
        configureUI()
        authenticationUser()
    }
    
    // MARK: - APIs
    
    func fetchUser (uid:String) {
        UserService.shared.fetchUser(uid: Auth.auth().currentUser!.uid) { (error, user) in
            if let error = error {
                print("DEBUG: \(error.localizedDescription)")
                self.renderPopup(title: "에러", message: "유저 정보를 가져오는데 실패하였습니다. ")
            }else {
                guard let user = user else { return }
                self.user = user
            }
            
        }
    }
    
    
    // MARK: - Helpers
    
    
    
    func authenticationUser() {
        if(Auth.auth().currentUser == nil) {
            // 로그인이 안되었을땐 logincontroller를 띄워준다.
            DispatchQueue.main.async {
                let login = UINavigationController(rootViewController: LoginController())
                login.modalPresentationStyle = .fullScreen
                self.present(login, animated: true, completion: nil)
            }
            
        }else {
            
            fetchUser(uid: Auth.auth().currentUser!.uid)
        }
    }
    
    
    
    @objc func twitButtonTapped(sender:UIButton) {
        
        guard let user = self.user else { return }
        
        let uploadTwitController = UINavigationController(rootViewController: UploadTweetController(user: user))
        present(uploadTwitController, animated: true, completion: nil)
    }
    
    func configureUI() {
        view.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        actionButton.bottomAnchor.constraint(equalTo: tabBar.topAnchor, constant: -24).isActive = true
        
    }
    
    func configureViewControllers(user:UserModel) {
        
        let feed = FeedController(user: user)
        feed.delegate = self
        let nav1 = UINavigationController(rootViewController: feed)
        nav1.tabBarItem.title = "피드"
        
        let explore = ExploreController(user: user)
        let nav2 = UINavigationController(rootViewController: explore)
        nav2.tabBarItem.title = "검색"
        
        let notifications = NotificationsController(user: user)
        let nav3 = UINavigationController(rootViewController: notifications)
        nav3.tabBarItem.title = "알림"
        
        
        let conversations = ConversationController(user: user)
        let nav4 = UINavigationController(rootViewController: conversations)
        nav4.tabBarItem.title = "대화"
        
        
        
        
        
        
        viewControllers = [nav1, nav2, nav3, nav4]
    }
}

extension MainTabBarController: FeedContollerProtocol {
    func logout() {
        
        do {
            try Auth.auth().signOut()
            let login = UINavigationController(rootViewController: LoginController())
            login.modalPresentationStyle = .fullScreen
            self.user = nil
            
            let feedNav = viewControllers?[0] as! UINavigationController
            let feedVC = feedNav.viewControllers[0] as! FeedController
            feedVC.tweets = []
            
            self.viewControllers = []
            
            
            
            
            present(login, animated: true, completion: nil)
            
        }catch let error {
            print("DEBUG: \(error.localizedDescription)")
        }
    }
    
    
}
