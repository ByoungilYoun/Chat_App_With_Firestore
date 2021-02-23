//
//  RegistrationController.swift
//  Chat_App_With_Firestore
//
//  Created by 윤병일 on 2021/02/17.
//

import UIKit

class RegistrationController : UIViewController {
  
  //MARK: - Properties
  private let plusPhotoButton : UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
    button.tintColor = .white
    button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
    return button
  }()
  
  private lazy var  emailContainerView : InputContainerView = {
    return  InputContainerView(image: UIImage(systemName: "envelope")!,
                                            textField: emailTextField)
  }()
  
  private lazy var fullNameContainerView : InputContainerView = {
    return  InputContainerView(image: UIImage(systemName: "person.fill")!,
                                            textField: fullnameTextField)
  }()
  
  private lazy var userNameContainerView : InputContainerView = {
    return  InputContainerView(image: UIImage(systemName: "person.fill")!,
                                            textField: usernameTextField)
  }()
  
  private lazy var passwordContainerView : InputContainerView = {
    return InputContainerView(image: UIImage(systemName: "lock")!,
                              textField: passwordTextField)
  }()
  
  private let emailTextField = CustomTextField(placeholder: "Email")
  private let fullnameTextField = CustomTextField(placeholder: "Full Name")
  private let usernameTextField = CustomTextField(placeholder: "User Name")
  
  private let passwordTextField : CustomTextField = {
    let tf = CustomTextField(placeholder: "Password")
    tf.isSecureTextEntry = true
    return tf
  }()
  
  private let signUpButton : UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Sign Up", for: .normal)
    button.layer.cornerRadius = 5
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    button.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
    button.setTitleColor(.white, for: .normal)
    button.setHeight(height: 50)
    return button
  }()
  
  private let alreadyHaveAccount : UIButton = {
    let button = UIButton(type: .system)
    let attributedTitle = NSMutableAttributedString(string: "Already have an account? ",
                                                    attributes: [.font : UIFont.systemFont(ofSize: 16),
                                                                 .foregroundColor : UIColor.white])
    attributedTitle.append(NSAttributedString(string: "Log In", attributes: [.font : UIFont.boldSystemFont(ofSize: 16),
                                                                              .foregroundColor : UIColor.white]))
    button.setAttributedTitle(attributedTitle, for: .normal)
    button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
    return button
  }()
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  //MARK: - Selectors
  @objc func handleSelectPhoto() {
    print("123")
  }
  
  @objc func handleShowLogin() {
    navigationController?.popViewController(animated: true)
  }
  //MARK: - Helpers
  func configureUI() {
    configureGradientLayer()
    
    view.addSubview(plusPhotoButton)
    plusPhotoButton.centerX(inView: view)
    plusPhotoButton.anchor(top : view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
    plusPhotoButton.setDimensions(height: 200, width: 200)
    
    let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                               fullNameContainerView,
                                               userNameContainerView,
                                               passwordContainerView,
                                               signUpButton])
    stack.axis = .vertical
    stack.spacing = 16
    
    view.addSubview(stack)
    stack.anchor(top : plusPhotoButton.bottomAnchor, left : view.leftAnchor, right : view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: -32)
    
    view.addSubview(alreadyHaveAccount)
    alreadyHaveAccount.anchor(left : view.leftAnchor, right : view.rightAnchor,
                            bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingLeft: 32, paddingRight: -32)
  }
}
