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
    fetchMessages()
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
  
  //MARK: - API
  // database 에서 메세지 가져오는 함수 
  func fetchMessages() {
    Service.fetchMessages(forUser: user) { messages in
      self.messages = messages
      self.collectionView.reloadData()
      self.collectionView.scrollToItem(at: [0,self.messages.count - 1], at: .bottom, animated: true) // 계속 새롭게 메세지를 가져올때마다 밑으로 내려간다.
    }
  }
  
  
  //MARK: - Helpers
  func configureUI() {
    collectionView.backgroundColor = .white
    configureNavigationBar(withTitle: user.username, prefersLargeTitle: false)
    
    collectionView.register(MessageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    collectionView.alwaysBounceVertical = true
    collectionView.keyboardDismissMode = .interactive //(키보드가 있는채로 채팅창을 위로 올리면 키보드가 사라진다.)
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
    cell.message?.user = user
    return cell
  }
}

  //MARK: - UICollectionViewDelegateFlowLayout
extension ChatController : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 16, left: 0, bottom: 16, right: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
    let estimatedSizeToCell = MessageCell(frame: frame)
    estimatedSizeToCell.message = messages[indexPath.row]
    estimatedSizeToCell.layoutIfNeeded()
    
    let targetSize = CGSize(width: view.frame.width, height: 1000)
    let estimatedSize = estimatedSizeToCell.systemLayoutSizeFitting(targetSize)
    return .init(width: view.frame.width, height: estimatedSize.height)
  }
}

  //MARK: - CustomInputAccessoryViewDelegate
extension ChatController : CustomInputAccessoryViewDelegate {
  func inputView(_ inputView: CustomInputAccessoryView, wantsToSend message: String) {
    
    // 메세지를 업로드 하고
    Service.uploadMessage(message, to: user) { error in
      if let error = error {
        print("Debug : Failed to upload message with error \(error.localizedDescription)")
        return
      }
      
      // 텍스트창을 비운다.
      inputView.clearMessageText()
    }
  }
}
