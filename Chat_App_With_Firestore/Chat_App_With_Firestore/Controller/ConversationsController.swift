//
//  ConversationsController.swift
//  Chat_App_With_Firestore
//
//  Created by 윤병일 on 2021/02/17.
//

import UIKit

class ConversationsController : UIViewController {
  //MARK: - Properties
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    configureNavigationBar()
  }
  
  //MARK: - Selectors
  @objc func showProfile() {
    print("123")
  }
  
  //MARK: - Helpers
  func configureUI() {
    view.backgroundColor = .systemBackground
    
    let image = UIImage(systemName: "person.circle.fill")
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showProfile))
  }
  
  func configureNavigationBar() {
    let appearance = UINavigationBarAppearance() // 네비게이션 바 백그라운드 appearance 생성
    appearance.configureWithOpaqueBackground()
    appearance.largeTitleTextAttributes = [.foregroundColor : UIColor.white] // 'Message' 타이틀 흰색으로 나타내기
    appearance.backgroundColor = .systemPurple
    
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.compactAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance
    
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.title = "Messages"
    
    navigationController?.navigationBar.tintColor = .white
    navigationController?.navigationBar.isTranslucent = true  // 반투명한
    
    navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
    
  }
}
