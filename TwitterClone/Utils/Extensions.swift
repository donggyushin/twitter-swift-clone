//
//  Extensions.swift
//  TwitterClone
//
//  Created by 신동규 on 2020/10/21.
//

import UIKit

extension UIViewController {
    
    
    func cleanNavigationBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.shadowColor = .clear
        navBarAppearance.shadowImage = UIImage()
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}

extension UIColor {
    static let facebookBlue = UIColor.init(displayP3Red: 66/255, green: 103/255, blue: 178/255, alpha: 1)
}
