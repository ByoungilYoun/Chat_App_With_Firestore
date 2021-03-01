//
//  ChatController.swift
//  Chat_App_With_Firestore
//
//  Created by 윤병일 on 2021/03/01.
//

import UIKit

private let reuseIdentifier = "MessageCell"

class ChatController : UICollectionViewController {
  
  //MARK: - Properties
  private let user : User
  
  private var messages = [Message]()
  
  var fromCurrentUser = false
  
  // 메세지 텍스트뷰와 send 버튼 있는 커스텀 뷰
  private lazy var customInputView : CustomInputAccessoryView = {
    let iv = CustomInputAccessoryView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
    iv.delegate = self
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
    
    collectionView.register(MessageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    collectionView.alwaysBounceVertical = true 
  }
}

  //MARK: - UICollectionViewDataSource
extension ChatController {
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return messages.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MessageCell
    cell.message = messages[indexPath.row]
    return cell
  }
}

  //MARK: - UICollectionViewDelegateFlowLayout
extension ChatController : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 16, left: 0, bottom: 16, right: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 50)
  }
}

  //MARK: - CustomInputAccessoryViewDelegate
extension ChatController : CustomInputAccessoryViewDelegate {
  func inputView(_ inputView: CustomInputAccessoryView, wantsToSend message: String) {
    inputView.messageInputTextView.text = nil 
    
    // 메세지를 업로드 하고
    Service.uploadMessage(message, to: user) { error in
      if let error = error {
        print("Debug : Failed to upload message with error \(error.localizedDescription)")
        return
      }
      
      // 텍스트창을 비운다.
      inputView.messageInputTextView.text = nil
    }
  }
}
