//
//  RegistrationController.swift
//  TwitterClone
//
//  Created by 신동규 on 2020/10/22.
//

import UIKit
import PopupDialog
import Firebase

class RegistrationController: UIViewController, UIGestureRecognizerDelegate {
    // MARK: - Properties
    
    private lazy var imagePicker = UIImagePickerController()
    
    var userProfileImage:UIImage?
    
    
    
    private lazy var profilePhotoButton:UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setImage(#imageLiteral(resourceName: "twitter_logo_blue").withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: UIControl.State.normal)
        button.heightAnchor.constraint(equalToConstant: 56).isActive = true
        button.widthAnchor.constraint(equalToConstant: 56).isActive = true
        button.layer.cornerRadius = 28
        button.layer.masksToBounds = true
        
        button.addTarget(self, action: #selector(selectPhotoFromLibrary), for: UIControl.Event.touchUpInside)
        
        return button
    }()
    
    private lazy var profilePhotoButtonText:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("클릭하여서 사진 가져오기", for: UIControl.State.normal)
        bt.addTarget(self, action: #selector(selectPhotoFromLibrary), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    private lazy var underline1:UIView = {
        let iv = UIView()
        iv.backgroundColor = .secondarySystemFill
        iv.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return iv
    }()
    
    private lazy var idTextField:UITextField = {
        let tf = UITextField()
        tf.placeholder = "이메일"
        return tf
    }()
    
    private lazy var idTextFieldView:UIView = {
        let iv = UIView()
        iv.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iv.addSubview(idTextField)
        idTextField.translatesAutoresizingMaskIntoConstraints = false
        idTextField.topAnchor.constraint(equalTo: iv.topAnchor).isActive = true
        idTextField.leftAnchor.constraint(equalTo: iv.leftAnchor).isActive = true
        idTextField.rightAnchor.constraint(equalTo: iv.rightAnchor).isActive = true
        idTextField.bottomAnchor.constraint(equalTo: iv.bottomAnchor).isActive = true
        
        iv.addSubview(underline1)
        underline1.translatesAutoresizingMaskIntoConstraints = false
        underline1.bottomAnchor.constraint(equalTo: iv.bottomAnchor).isActive = true
        underline1.leftAnchor.constraint(equalTo: iv.leftAnchor).isActive = true
        underline1.rightAnchor.constraint(equalTo: iv.rightAnchor).isActive = true
        return iv
    }()
    
    private lazy var underline2:UIView = {
        let iv = UIView()
        iv.backgroundColor = .secondarySystemFill
        iv.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return iv
    }()
    
    private lazy var passwordTextField:UITextField = {
        let tf = UITextField()
        tf.placeholder = "비밀번호"
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private lazy var passwordTextFieldView:UIView = {
        let iv = UIView()
        iv.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iv.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.topAnchor.constraint(equalTo: iv.topAnchor).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: iv.leftAnchor).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: iv.rightAnchor).isActive = true
        passwordTextField.bottomAnchor.constraint(equalTo: iv.bottomAnchor).isActive = true
        
        iv.addSubview(underline2)
        underline2.translatesAutoresizingMaskIntoConstraints = false
        underline2.bottomAnchor.constraint(equalTo: iv.bottomAnchor).isActive = true
        underline2.leftAnchor.constraint(equalTo: iv.leftAnchor).isActive = true
        underline2.rightAnchor.constraint(equalTo: iv.rightAnchor).isActive = true
        return iv
    }()
    
    private lazy var underline3:UIView = {
        let iv = UIView()
        iv.backgroundColor = .secondarySystemFill
        iv.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return iv
    }()
    
    private lazy var password2TextField:UITextField = {
        let tf = UITextField()
        tf.placeholder = "비밀번호 확인"
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private lazy var registButton:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.setTitle("회원가입", for: UIControl.State.normal)
        bt.addTarget(self, action: #selector(makeNewUser), for: UIControl.Event.touchUpInside)
        return bt
    }()
    
    private lazy var buttonToLoginController:UIButton = {
        let bt = UIButton(type: UIButton.ButtonType.system)
        bt.addTarget(self, action: #selector(goBack), for: UIControl.Event.touchUpInside)
        var firstAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black, .font:UIFont.systemFont(ofSize: 12)]
        var secondAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, .font:UIFont.systemFont(ofSize: 14)]
        
        if traitCollection.userInterfaceStyle == .dark {
            firstAttributes = [.foregroundColor: UIColor.white, .font:UIFont.systemFont(ofSize: 12)]
            secondAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, .font:UIFont.systemFont(ofSize: 14)]
        }
        

        let firstString = NSMutableAttributedString(string: "이미 계정이 있으신가요? ", attributes: firstAttributes)
        let secondString = NSAttributedString(string: "로그인", attributes: secondAttributes)
        

        firstString.append(secondString)
        
        
        
        bt.setAttributedTitle(firstString, for: UIControl.State.normal)
        return bt
    }()
    
    private lazy var password2TextFieldView:UIView = {
        let iv = UIView()
        iv.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iv.addSubview(password2TextField)
        password2TextField.translatesAutoresizingMaskIntoConstraints = false
        password2TextField.topAnchor.constraint(equalTo: iv.topAnchor).isActive = true
        password2TextField.leftAnchor.constraint(equalTo: iv.leftAnchor).isActive = true
        password2TextField.rightAnchor.constraint(equalTo: iv.rightAnchor).isActive = true
        password2TextField.bottomAnchor.constraint(equalTo: iv.bottomAnchor).isActive = true
        
        iv.addSubview(underline3)
        underline3.translatesAutoresizingMaskIntoConstraints = false
        underline3.bottomAnchor.constraint(equalTo: iv.bottomAnchor).isActive = true
        underline3.leftAnchor.constraint(equalTo: iv.leftAnchor).isActive = true
        underline3.rightAnchor.constraint(equalTo: iv.rightAnchor).isActive = true
        return iv
    }()
    
    

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // call the 'keyboardWillShow' function when the view controller receive notification that keyboard is going to be shown
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        
        
        
        configureUI()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    // MARK: - Configures
    func configureUI() {
        view.backgroundColor = .systemBackground
        let backItem = UIBarButtonItem(title: "이전", style: UIBarButtonItem.Style.plain, target: self, action: #selector(goBack))
        
        
        
        navigationItem.leftBarButtonItem = backItem
        
        view.addSubview(profilePhotoButton)
        profilePhotoButton.translatesAutoresizingMaskIntoConstraints = false
        profilePhotoButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        profilePhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(profilePhotoButtonText)
        profilePhotoButtonText.translatesAutoresizingMaskIntoConstraints = false
        profilePhotoButtonText.topAnchor.constraint(equalTo: profilePhotoButton.bottomAnchor, constant: 10).isActive = true
        profilePhotoButtonText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        let textfieldStack = UIStackView(arrangedSubviews: [idTextFieldView, passwordTextFieldView, password2TextFieldView])
        textfieldStack.axis = .vertical
        textfieldStack.spacing = 10
        
        view.addSubview(textfieldStack)
        textfieldStack.translatesAutoresizingMaskIntoConstraints = false
        textfieldStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        textfieldStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        textfieldStack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        view.addSubview(registButton)
        registButton.translatesAutoresizingMaskIntoConstraints = false
        registButton.topAnchor.constraint(equalTo: textfieldStack.bottomAnchor, constant: 20).isActive = true
        registButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(buttonToLoginController)
        buttonToLoginController.translatesAutoresizingMaskIntoConstraints = false
        buttonToLoginController.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        buttonToLoginController.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    // MARK: - Helpers
    
   
    
    
    
    @objc func makeNewUser(){
        
        // TODO: - 회원가입 버튼을 무력화시킨다.
        registButton.isEnabled = false
        
        guard let email = idTextField.text else {
            registButton.isEnabled = true
            return
            
        }
        
        guard let password1 = passwordTextField.text else {
            registButton.isEnabled = true
            return  }
        
        guard let password2 = password2TextField.text else {
            registButton.isEnabled = true
            return }
        
        if(email == "") {
            renderPopup(title: "경고", message: "이메일을 입력해주세요")
            registButton.isEnabled = true
            return
        }
        
        if (password1 != password2) {
            renderPopup(title: "경고", message: "비밀번호와 비밀번호확인이 서로 일치하지 않습니다")
            registButton.isEnabled = true
            return
        }
        
        AuthService.shared.registerUser(email: email, password1: password1, userProfileImage: self.userProfileImage) { (success, error, errorMessage, uid) in
            if let error = error, let errorMessage = errorMessage {
                print("DEBUG: \(error.localizedDescription)")
                self.renderPopup(title: "에러", message: errorMessage)
            }else {
                
                print("DEBUG: 유저 회원가입 성공")
                // 로그인 시켜준다
                let mainTabController = UIApplication.shared.windows.first!.rootViewController as! MainTabBarController
                
                mainTabController.fetchUser(uid: uid!)
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @objc func selectPhotoFromLibrary(sender:UIButton) {
        print("라이브러리에서 사진 가져오기")
        
        present(imagePicker, animated: true, completion: nil)
        
        
        
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
        
        
        
        
        
        buttonToLoginController.setAttributedTitle(firstString, for: UIControl.State.normal)
    }
}


extension RegistrationController:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        
        profilePhotoButton.setImage(profileImage.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: UIControl.State.normal)
        
        userProfileImage = profileImage
        
        
        dismiss(animated: true, completion: nil)
    }
}
