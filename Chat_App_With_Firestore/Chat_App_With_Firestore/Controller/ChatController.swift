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
  
  // 메세지 텍스트뷰와 send 버튼 있는 커스텀 뷰
  private lazy var customInputView : CustomInputAccessoryView = {
    let iv = CustomInputAccessoryView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
    return iv
  }()
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
  
  // customInputView 를 할때 해준다.
  override var inputAccessoryView: UIView? {
    get {
      return customInputView
    }
  }
  
  // customInputView 를 할때 해준다.
  override var canBecomeFirstResponder: Bool {
    return true
  }
  
  //MARK: - Helpers
  func configureUI() {
    collectionView.backgroundColor = .white
    configureNavigationBar(withTitle: user.username, prefersLargeTitle: false)
  }
}
