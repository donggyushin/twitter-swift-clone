//
//  FeedController.swift
//  TwitterClone
//
//  Created by 신동규 on 2020/10/21.
//

import UIKit

class FeedController: UIViewController {
    
    // MARK: - Properties
    private lazy var twitterLogoImageView:UIImageView = {
       let imageView = UIImageView(image: #imageLiteral(resourceName: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Lifecycle
    
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
