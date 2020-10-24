//
//  FeedController.swift
//  TwitterClone
//
//  Created by 신동규 on 2020/10/21.
//

import UIKit

class ConversationController: UIViewController {
    
    // MARK: - Properties
    let user:UserModel
    
    // MARK: - Lifecycle
    
    init(user:UserModel) {
        
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Helpers
    func configureUI() {
        
        cleanNavigationBar()
        
        view.backgroundColor = .systemBackground
        navigationItem.title = "대화"
    }
}
