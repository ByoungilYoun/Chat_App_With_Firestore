//
//  LoginController.swift
//  Chat_App_With_Firestore
//
//  Created by 윤병일 on 2021/02/17.
//

import UIKit

class LoginController : UIViewController {
  
  //MARK: - Properties
  private let iconImage : UIImageView = {
    let iv = UIImageView()
    iv.image = UIImage(systemName: "bubble.right")
    iv.tintColor = .white
    return iv
  }()
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  //MARK: - Helpers
  func configureUI() {
    navigationController?.navigationBar.isHidden = true
    navigationController?.navigationBar.barStyle = .black
    view.backgroundColor = .systemPurple
    
    configureGradientLayer()
    
    view.addSubview(iconImage)
    iconImage.translatesAutoresizingMaskIntoConstraints = false
    
    iconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    iconImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    iconImage.heightAnchor.constraint(equalToConstant: 120).isActive = true
    iconImage.widthAnchor.constraint(equalToConstant: 120).isActive = true
    
  }
  
  func configureGradientLayer() {
    let gradient = CAGradientLayer()
    gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor]
    gradient.locations = [0, 1]
    view.layer.addSublayer(gradient)
    gradient.frame = view.frame
  }
}
