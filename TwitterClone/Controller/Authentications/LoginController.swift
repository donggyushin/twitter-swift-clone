//
//  LoginController.swift
//  TwitterClone
//
//  Created by 신동규 on 2020/10/21.
//

import UIKit
import Firebase
import PopupDialog

class LoginController: UIViewController {
    // MARK: - Properties
    
    
    private lazy var LogoImageView:UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "twitter_logo_blue"))
        iv.contentMode = .scaleAspectFit
        iv.heightAnchor.constraint(equalToConstant: 56).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 56).isActive = true
        return iv
    }()
    
    private lazy var emailContainerView:UIView = {
        let view = UIView()
        
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let tf = emailTextField
        
        view.addSubview(tf)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tf.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tf.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tf.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        let underLine = UIView()
        view.addSubview(underLine)
        underLine.translatesAutoresizingMaskIntoConstraints = false
        underLine.backgroundColor = .tertiarySystemFill
        underLine.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        underLine.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        underLine.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        underLine.heightAnchor.constraint(equalToConstant: 1).isActive = true 
        
        return view
    }()
    
    private lazy var passwordContainerView:UIView = {
        let view = UIView()
        
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let tf = passwordTextField
        view.addSubview(tf)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tf.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tf.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tf.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        let underLine = UIView()
        view.addSubview(underLine)
        underLine.translatesAutoresizingMaskIntoConstraints = false
        underLine.backgroundColor = .tertiarySystemFill
        underLine.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        underLine.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        underLine.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        underLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        return view
    }()
    
    private lazy var emailTextField:UITextField = {
        let tf = UITextField()
        tf.placeholder = "이메일"
        
        return tf
    }()
    
    private lazy var passwordTextField:UITextField = {
        let tf = UITextField()
        tf.placeholder = "비밀번호"
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private lazy var loginButton:UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("로그인", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(loginButtonTapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    
    
    private lazy var notyetAccountButton1:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        
        bt.addTarget(self, action: #selector(goToNewAccountController), for: UIControl.Event.touchUpInside)


        var firstAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black, .font:UIFont.systemFont(ofSize: 12)]
        var secondAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, .font:UIFont.systemFont(ofSize: 14)]
        
        if traitCollection.userInterfaceStyle == .dark {
            firstAttributes = [.foregroundColor: UIColor.white, .font:UIFont.systemFont(ofSize: 12)]
            secondAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, .font:UIFont.systemFont(ofSize: 14)]
        }
        

        let firstString = NSMutableAttributedString(string: "아직 계정이 없으신가요? ", attributes: firstAttributes)
        let secondString = NSAttributedString(string: "회원가입", attributes: secondAttributes)
        

        firstString.append(secondString)
        
        
        
        bt.setAttributedTitle(firstString, for: UIControl.State.normal)
        return bt
    }()
    
    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // call the 'keyboardWillShow' function when the view controller receive notification that keyboard is going to be shown
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        configureUI()
    }
    
    // MARK: - Helpers
    
    
    
    @objc func keyboardWillHide(notification: NSNotification) {
      // move back the root view origin to zero
      self.view.frame.origin.y = 0
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           // if keyboard size is not available for some reason, dont do anything
           return
        }
      
      // move the root view up by the distance of keyboard height
      self.view.frame.origin.y = 0 - keyboardSize.height / 2
    }
    
    @objc func loginButtonTapped() {
        guard let email = self.emailTextField.text else { return }
        guard let password = self.passwordTextField.text else { return }
        
        loginButton.isEnabled = false
         
        
        AuthService.shared.signInUser(email: email, password: password) { (result, error) in
            if let error = error {
                print("DEBUG: \(error.localizedDescription)")
                self.renderPopup(title: "에러", message: "로그인에 실패하였습니다")
                self.loginButton.isEnabled = true
            }else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc func goToNewAccountController() {
        
        let registrationController = RegistrationController()
        
        navigationController?.pushViewController(registrationController, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func configureUI() {
        view.backgroundColor = UIColor.systemBackground
        cleanNavigationBar()
        view.addSubview(LogoImageView)
        LogoImageView.translatesAutoresizingMaskIntoConstraints = false
        LogoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        LogoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView])
        stack.axis = .vertical
        stack.spacing = 10
        
        
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
//        stack.topAnchor.constraint(equalTo: LogoImageView.bottomAnchor, constant: 50).isActive = true
        stack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true 
        stack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        stack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 20).isActive = true
        loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        loginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        
        
        let stack2 = UIStackView(arrangedSubviews: [notyetAccountButton1])
        stack2.axis = NSLayoutConstraint.Axis.horizontal
        stack2.distribution = .fillProportionally
        stack2.alignment = .center
        stack2.spacing = 5
        
        
        
        let stack3 = UIStackView(arrangedSubviews: [stack2])
        stack3.axis = .vertical
        stack3.alignment = .center
        stack3.distribution = .fill
        view.addSubview(stack3)
        stack3.translatesAutoresizingMaskIntoConstraints = false
        stack3.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        stack3.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        stack3.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        stack3.addSubview(stack2)
        
        
        
        
    }
    
    // MARK: - Override
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        
        var firstAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black, .font:UIFont.systemFont(ofSize: 12)]
        var secondAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, .font:UIFont.systemFont(ofSize: 14)]
        
        if traitCollection.userInterfaceStyle == .dark {
            firstAttributes = [.foregroundColor: UIColor.white, .font:UIFont.systemFont(ofSize: 12)]
            secondAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, .font:UIFont.systemFont(ofSize: 14)]
        }
        

        let firstString = NSMutableAttributedString(string: "아직 계정이 없으신가요? ", attributes: firstAttributes)
        let secondString = NSAttributedString(string: "회원가입", attributes: secondAttributes)
        

        firstString.append(secondString)
        
        
        
        notyetAccountButton1.setAttributedTitle(firstString, for: UIControl.State.normal)
    }
}
