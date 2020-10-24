//
//  UploadTweetController.swift
//  TwitterClone
//
//  Created by 신동규 on 2020/10/24.
//

import UIKit
import SDWebImage

class UploadTweetController:UIViewController {
    // MARK: - Properties
    let user:UserModel
    
    private let captionTextView = CaptionTextView()
    
    private lazy var actionButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("게시하기", for: UIControl.State.normal)
        bt.layer.borderWidth = 1
        bt.layer.borderColor = UIColor.facebookBlue.cgColor
        bt.frame = CGRect(x: 0, y: 0, width: 80, height: 38)
        bt.layer.cornerRadius = 19
        bt.addTarget(self, action: #selector(tweet), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    private lazy var userProfileImage:UIImageView = {
        let iv = UIImageView()
        
        if let profileUrlString = self.user.profileImage {
            if let url = URL(string: profileUrlString) {
                iv.sd_setImage(with: url, completed: nil)
            }else {
                iv.image = #imageLiteral(resourceName: "TwitterLogo").withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            }
        }else {
            iv.image = #imageLiteral(resourceName: "TwitterLogo").withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        }
        iv.heightAnchor.constraint(equalToConstant: 48).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 48).isActive = true
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 24
        iv.clipsToBounds = true
        return iv
    }()
    
    // MARK: - Lifecycles
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
    
    // MARK: - helpers
    
    // MARK: - Configures
    func configureUI(){
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionButton)
        
        
        
        let stack = UIStackView(arrangedSubviews: [userProfileImage, captionTextView])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.distribution = .fill
        stack.alignment = .top
        
        
        
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        stack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        stack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true


        
        
    }
    
    // MARK: Selectors
    @objc func tweet(){
        print("DEBUG: Tweet action button tapped")
    }
    
    // MARK: - APIs
}
