//
//  CustomInputAccessoryView.swift
//  Chat_App_With_Firestore
//
//  Created by 윤병일 on 2021/03/01.
//

import UIKit

protocol CustomInputAccessoryViewDelegate : class {
  func inputView(_ inputView : CustomInputAccessoryView, wantsToSend message : String)
}

class CustomInputAccessoryView : UIView {
  //MARK: - Properties
  
  weak var delegate : CustomInputAccessoryViewDelegate?
  
  lazy var messageInputTextView : UITextView = {
    let tv = UITextView()
    tv.font = UIFont.systemFont(ofSize: 16)
    tv.isScrollEnabled = false
    return tv
  }()
  
  private lazy var sendButton : UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Send", for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    button.setTitleColor(.systemPurple, for: .normal)
    button.addTarget(self, action: #selector(handleSendMessage), for: .touchUpInside)
    return button
  }()
  
  private let placeholderLabel : UILabel = {
    let label = UILabel()
    label.text = "Enter Message"
    label.font = UIFont.systemFont(ofSize: 16)
    label.textColor = .lightGray
    return label
  }()
  //MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    autoresizingMask = .flexibleHeight
    
    layer.shadowOpacity = 0.25
    layer.shadowRadius = 10
    layer.shadowOffset = .init(width: 0, height: -8)
    layer.shadowColor = UIColor.lightGray.cgColor
    
    addSubview(sendButton)
    sendButton.anchor(top : topAnchor, right: rightAnchor, paddingTop: 4, paddingRight: -8)
    sendButton.setDimensions(height: 50, width: 50)
    
    addSubview(messageInputTextView)
    messageInputTextView.anchor(top : topAnchor, left: leftAnchor, right: sendButton.leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, paddingTop: 12, paddingLeft: 4, paddingRight: -8, paddingBottom: -8)
    
    addSubview(placeholderLabel)
    placeholderLabel.anchor(left : messageInputTextView.leftAnchor, paddingLeft: 4)
    placeholderLabel.centerY(inView: messageInputTextView)
    
    // UITextView 에 placeholder 속성이 없어서 라벨로 대체했는데 글씨를 쓸때 안보이게 하기 위해서 노티피케이션센터 이용
    NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange), name: UITextView.textDidChangeNotification, object: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override var intrinsicContentSize: CGSize {
    return .zero
  }
  
  //MARK: - Selectors
  @objc func handleSendMessage() {
    guard let message = messageInputTextView.text else {return}
    delegate?.inputView(self, wantsToSend: message)
  }
  
  @objc func handleTextInputChange() {
    placeholderLabel.isHidden = !self.messageInputTextView.text.isEmpty
  }
}
