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
        
        configureViewControllers()
        configureUI()
        authenticationUser()
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
    }
    
    @objc func twitButtonTapped(sender:UIButton) {
        // 일시적으로 로그아웃 구현
        do {
            try Auth.auth().signOut()
            let login = UINavigationController(rootViewController: LoginController())
            login.modalPresentationStyle = .fullScreen
            present(login, animated: true, completion: nil)
            
        }catch let error {
            print("DEBUG: \(error.localizedDescription)")
        }
        
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
