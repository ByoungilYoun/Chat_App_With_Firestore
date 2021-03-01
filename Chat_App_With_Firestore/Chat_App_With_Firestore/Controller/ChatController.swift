//
//  ChatController.swift
//  Chat_App_With_Firestore
//
//  Created by 윤병일 on 2021/03/01.
//

import UIKit

class ChatController : UICollectionViewController {
  
  //MARK: - Properties
  private let user : User
  //MARK: - Lifecycle
  
  init(user : User) {
    self.user = user
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    print("Debug : User in chat controller is \(user.username)")
  }
  
  //MARK: - Helpers
  func configureUI() {
    collectionView.backgroundColor = .white
  }
}
