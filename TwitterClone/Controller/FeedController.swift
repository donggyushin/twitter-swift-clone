//
//  FeedController.swift
//  TwitterClone
//
//  Created by 신동규 on 2020/10/21.
//

import UIKit

class FeedController: UIViewController {
    
    // MARK: - Properties
    let user:UserModel
    
    private lazy var twitterLogoImageView:UIImageView = {
       let imageView = UIImageView(image: #imageLiteral(resourceName: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
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
        navigationItem.titleView = twitterLogoImageView
    }
}
