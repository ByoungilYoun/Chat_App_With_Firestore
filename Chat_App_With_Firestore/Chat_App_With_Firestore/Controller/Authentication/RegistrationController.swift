//
//  RegistrationController.swift
//  Chat_App_With_Firestore
//
//  Created by 윤병일 on 2021/02/17.
//

import UIKit
import Firebase

class RegistrationController : UIViewController {
  
  //MARK: - Properties
  private var viewModel = RegistrationViewModel()
  
  private var profileImage : UIImage?
  
  private let plusPhotoButton : UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
    button.tintColor = .white
    button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
    button.clipsToBounds = true
    button.imageView?.contentMode = .scaleAspectFill
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
    button.isEnabled = false
    button.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
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
    configureNotificationObservers()
  }
  
  //MARK: - Selectors
  
  @objc func handleRegistration() {
    guard let email = emailTextField.text else {return}
    guard let password = passwordTextField.text else {return}
    guard let fullname = fullnameTextField.text else {return}
    guard let username = usernameTextField.text?.lowercased() else {return}
    guard let profileImage = profileImage else {return}
    
    guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else {return}
    
    // storage 에 올라갈 이미지 저장 파일 이름 설정
    let fileName = NSUUID().uuidString
    let ref = Storage.storage().reference(withPath: "/profile_images/\(fileName)")
    
    // 서버에 업로드
    ref.putData(imageData, metadata: nil) { (meta, error) in
      if let error = error {
        print("Debug : Failed to upload image with error \(error.localizedDescription)")
        return
      }
      
      ref.downloadURL { (url, error) in
        guard let profileImageUrl = url?.absoluteString else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
          if let error = error {
            print("Debug : Failed to create user with error \(error.localizedDescription)")
            return
          }
          
          guard let uid = result?.user.uid else {return}
          
          let data = ["email" : email,
                      "fullname" : fullname,
                      "profileImageUrl" : profileImageUrl,
                      "uid" : uid,
                      "username" : username] as [String : Any]
          
          Firestore.firestore().collection("users").document(uid).setData(data) { (error) in
            if let error = error {
              print("Debug : Failed to upload user data with error \(error.localizedDescription)")
              return
            }
            
            print("Debug : Did create user...")
          }
        }
      }
    }
  }
  
  @objc func textDidChange(sender : UITextField) {
    if sender == emailTextField {
      viewModel.email = sender.text
    } else if sender == passwordTextField {
      viewModel.password = sender.text
    } else if sender == fullnameTextField {
      viewModel.fullname = sender.text
    } else {
      viewModel.username = sender.text
    }
    
    checkFormStatus()
  }
  
  @objc func handleSelectPhoto() {
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    present(imagePickerController, animated: true, completion: nil)
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
  
  // configureNotificationObservers()
  func configureNotificationObservers() {
    emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
  }
}

//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension RegistrationController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    let image = info[.originalImage] as? UIImage
    profileImage = image
    plusPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
    plusPhotoButton.layer.borderColor = UIColor.white.cgColor
    plusPhotoButton.layer.borderWidth = 3.0
    plusPhotoButton.layer.cornerRadius = 200 / 2
    dismiss(animated: true, completion: nil)
  }
}

//MARK: - AuthenticationControllerProtocol
extension RegistrationController : AuthenticationControllerProtocol {
  func checkFormStatus() {
    if viewModel.formIsValid {
      signUpButton.isEnabled = true
      signUpButton.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
    } else {
      signUpButton.isEnabled = false
      signUpButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
    }
  }
}
