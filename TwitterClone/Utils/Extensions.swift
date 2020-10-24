//
//  Extensions.swift
//  TwitterClone
//
//  Created by 신동규 on 2020/10/21.
//

import UIKit
import PopupDialog

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}

extension UIViewController {
    
    func renderPopup(title:String, message:String){
        
        
        

        let popup = PopupDialog(title: title, message: message)
        let buttonOne = DefaultButton(title: "확인", height: 60) {
            
        }
        
        popup.addButton(buttonOne)
        
        if self.traitCollection.userInterfaceStyle == .dark {
            dialogPopupDarkMode()
        }
        present(popup, animated: true, completion: nil)
    }
    
    func dialogPopupDarkMode(){
        // Customize dialog appearance
        let pv = PopupDialogDefaultView.appearance()
        pv.titleFont    = UIFont(name: "HelveticaNeue-Light", size: 16)!
        pv.titleColor   = .white
        pv.messageFont  = UIFont(name: "HelveticaNeue", size: 14)!
        pv.messageColor = UIColor(white: 0.8, alpha: 1)

        // Customize the container view appearance
        let pcv = PopupDialogContainerView.appearance()
        pcv.backgroundColor = UIColor(red:0.23, green:0.23, blue:0.27, alpha:1.00)
        pcv.cornerRadius    = 2
        pcv.shadowEnabled   = true
        pcv.shadowColor     = .black

        // Customize overlay appearance
        let ov = PopupDialogOverlayView.appearance()
        ov.blurEnabled     = true
        ov.blurRadius      = 30
        ov.liveBlurEnabled = true
        ov.opacity         = 0.7
        ov.color           = .black

        // Customize default button appearance
        let db = DefaultButton.appearance()
        db.titleFont      = UIFont(name: "HelveticaNeue-Medium", size: 14)!
        db.titleColor     = .white
        db.buttonColor    = UIColor(red:0.25, green:0.25, blue:0.29, alpha:1.00)
        db.separatorColor = UIColor(red:0.20, green:0.20, blue:0.25, alpha:1.00)

        // Customize cancel button appearance
        let cb = CancelButton.appearance()
        cb.titleFont      = UIFont(name: "HelveticaNeue-Medium", size: 14)!
        cb.titleColor     = UIColor(white: 0.6, alpha: 1)
        cb.buttonColor    = UIColor(red:0.25, green:0.25, blue:0.29, alpha:1.00)
        cb.separatorColor = UIColor(red:0.20, green:0.20, blue:0.25, alpha:1.00)
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
