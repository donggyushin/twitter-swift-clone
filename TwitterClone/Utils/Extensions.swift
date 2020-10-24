//
//  Extensions.swift
//  TwitterClone
//
//  Created by 신동규 on 2020/10/21.
//

import UIKit
import PopupDialog

extension UIViewController {
    
    func renderPopup(title:String, message:String){
        

        let popup = PopupDialog(title: title, message: message)
        let buttonOne = DefaultButton(title: "확인", height: 60) {
            
        }
        
        popup.addButton(buttonOne)
        present(popup, animated: true, completion: nil)
    }
    
    
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
