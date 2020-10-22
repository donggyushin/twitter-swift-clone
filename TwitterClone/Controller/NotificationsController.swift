//
//  FeedController.swift
//  TwitterClone
//
//  Created by 신동규 on 2020/10/21.
//

import UIKit

class NotificationsController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Helpers
    func configureUI() {
        
        cleanNavigationBar()
        
        view.backgroundColor = .systemBackground
        navigationItem.title = "알림"
    }
}
