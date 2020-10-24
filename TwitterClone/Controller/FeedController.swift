//
//  FeedController.swift
//  TwitterClone
//
//  Created by 신동규 on 2020/10/21.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "TweetCell"

protocol FeedContollerProtocol:class {
    func logout()
}

class FeedController: UIViewController {
    
    // MARK: - Properties
    let user:UserModel
    weak var delegate:FeedContollerProtocol?
    var tweets:[TweetModel] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    var collectionView:UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private lazy var profileImageButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.heightAnchor.constraint(equalToConstant: 40).isActive = true
        bt.widthAnchor.constraint(equalToConstant: 40).isActive = true
        bt.layer.cornerRadius = 20
        bt.contentMode = .scaleAspectFit
        bt.layer.masksToBounds = true
        if let userProfileImage = self.user.profileImage {

            if let url = URL(string: userProfileImage) {

                bt.sd_setBackgroundImage(with: url, for: UIControl.State.normal, completed: nil)
            }else {
                bt.setImage(#imageLiteral(resourceName: "twitter_logo_blue").withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: UIControl.State.normal)
            }

        }else {
            bt.setImage(#imageLiteral(resourceName: "twitter_logo_blue").withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: UIControl.State.normal)
        }
        
        return bt
    }()
    
    private lazy var twitterLogoImageView:UIImageView = {
       let imageView = UIImageView(image: #imageLiteral(resourceName: "twitter_logo_blue"))
        imageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
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
        
        fetchTweets()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    // MARK: - APIs
    
    func fetchTweets () {
        TweetService.shared.fetchTweets { (error, tweets) in
            if let error = error {
                self.renderPopup(title: "에러", message: error.localizedDescription)
                return
            }
            
            self.tweets = tweets
        }
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        
        cleanNavigationBar()
        
        view.backgroundColor = .systemBackground
        navigationItem.titleView = twitterLogoImageView
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(logoutButtonTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageButton)
        
        
        
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    // MARK: - Selectors
    @objc func logoutButtonTapped () {
        self.delegate?.logout()
    }
}


extension FeedController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tweets.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
        cell.tweet = self.tweets[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let tweet = self.tweets[indexPath.row]
        let message = tweet.message
        let devicewidth = view.frame.width
        let width = devicewidth - 16 - 16 - 48 - 9
        let messageHeight = message.height(withConstrainedWidth: width, font: UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.medium))
        
        
        
        if (messageHeight > 32) {
            return CGSize(width: view.frame.width, height: 120 + messageHeight)
        }else {
            return CGSize(width: view.frame.width, height: 130)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}


extension FeedController:TweetCellProtocol {

    func navigateToProfileController(user: UserModel) {
        let profileController = ProfileController(user: user)
        
        navigationController?.pushViewController(profileController, animated: true)
    }
}
