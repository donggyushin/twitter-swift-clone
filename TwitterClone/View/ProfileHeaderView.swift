//
//  ProfileHeaderView.swift
//  TwitterClone
//
//  Created by 신동규 on 2020/10/24.
//

import UIKit

class ProfileHeaderView: UICollectionReusableView {
    
    // MARK: - Properties
    var user:UserModel? {
        didSet {
            guard let user = self.user else { return }
            print("DEBUG: user is \(user)")
        }
    }
    
    // MARK: - Lifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configures
    func configureUI() {
        backgroundColor = .systemBackground
    }
}
