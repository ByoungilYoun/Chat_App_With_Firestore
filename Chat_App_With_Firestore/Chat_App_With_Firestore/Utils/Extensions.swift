//
//  Extensions.swift
//  Chat_App_With_Firestore
//
//  Created by 윤병일 on 2021/02/17.
//

import UIKit
import JGProgressHUD

  //MARK: - extension UIView
extension UIView {
  func anchor(top : NSLayoutYAxisAnchor? = nil,
              left : NSLayoutXAxisAnchor? = nil,
              right : NSLayoutXAxisAnchor? = nil,
              bottom : NSLayoutYAxisAnchor? = nil,
              paddingTop : CGFloat = 0,
              paddingLeft : CGFloat = 0,
              paddingRight : CGFloat = 0,
              paddingBottom : CGFloat = 0,
              width : CGFloat? = nil,
              height : CGFloat? = nil) {
    
    translatesAutoresizingMaskIntoConstraints = false
    
    if let top = top {
      topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
    }
    
    if let left = left {
      leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
    }
    
    if let right = right {
      rightAnchor.constraint(equalTo: right, constant: paddingRight).isActive = true
    }
    
    if let bottom = bottom {
      bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
    }
    
    if let width = width {
      widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    if let height = height {
      heightAnchor.constraint(equalToConstant: height).isActive = true
    }
  }
  
  func centerX(inView view : UIView) {
    translatesAutoresizingMaskIntoConstraints = false
    centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
  }
  
  func centerY(inView view : UIView, leftAnchor : NSLayoutXAxisAnchor? = nil, paddingLeft : CGFloat = 0, constant : CGFloat = 0) {
  
    translatesAutoresizingMaskIntoConstraints = false
    centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
    
    if let left = leftAnchor {
      anchor(left : left , paddingLeft: paddingLeft)
    }
  }
  
  func setDimensions(height : CGFloat, width :CGFloat) {
    translatesAutoresizingMaskIntoConstraints = false
    heightAnchor.constraint(equalToConstant: height).isActive = true
    widthAnchor.constraint(equalToConstant: width).isActive = true
  }
  
  func setHeight(height : CGFloat) {
    translatesAutoresizingMaskIntoConstraints = false
    heightAnchor.constraint(equalToConstant: height).isActive = true
  }
  
  func setWidth(width : CGFloat) {
    translatesAutoresizingMaskIntoConstraints = false
    widthAnchor.constraint(equalToConstant: width).isActive = true
  }
  
  func fillSuperView() {
    translatesAutoresizingMaskIntoConstraints = false
    guard let superViewTopAnchor = superview?.topAnchor,
      let superViewLeftAnchor = superview?.leftAnchor,
      let superViewRightAnchor = superview?.rightAnchor,
      let superViewBottomAnchor = superview?.bottomAnchor else { return }
    
    anchor(top: superViewTopAnchor, left: superViewLeftAnchor, right: superViewRightAnchor, bottom: superViewBottomAnchor)
  }
}

  //MARK: - extension UIViewController
extension UIViewController {
  
  static let hud = JGProgressHUD(style: .dark) // hud 인스턴스를 한개 만들어서 showLoader 함수를 통해 사용한다.
  
  func configureGradientLayer() {
    let gradient = CAGradientLayer()
    gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor]
    gradient.locations = [0, 1]
    view.layer.addSublayer(gradient)
    gradient.frame = view.frame
  }
  
  // 로딩을 보여주는 extension 함수
  func showLoader(_ show : Bool, withText text : String? = "Loading") {
    view.endEditing(true)
    UIViewController.hud.textLabel.text = text
    
    if show {
      UIViewController.hud.show(in: view)
    } else {
      UIViewController.hud.dismiss()
    }
  }
  
  
  func configureNavigationBar(withTitle title : String, prefersLargeTitle : Bool) {
    let appearance = UINavigationBarAppearance() // 네비게이션 바 백그라운드 appearance 생성
    appearance.configureWithOpaqueBackground()
    appearance.largeTitleTextAttributes = [.foregroundColor : UIColor.white] // 'Message' 타이틀 흰색으로 나타내기
    appearance.backgroundColor = .systemPurple
    
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.compactAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance
    
    navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitle
    navigationItem.title = title
    
    navigationController?.navigationBar.tintColor = .white
    navigationController?.navigationBar.isTranslucent = true  // 반투명한
    
    navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
    
  }
}
