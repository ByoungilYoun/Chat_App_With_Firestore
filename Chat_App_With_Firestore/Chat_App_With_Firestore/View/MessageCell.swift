//
//  MessageCell.swift
//  Chat_App_With_Firestore
//
//  Created by 윤병일 on 2021/03/01.
//

import UIKit

class MessageCell : UICollectionViewCell {
  //MARK: - Properties
  
  private let profileImageView : UIImageView  = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    iv.backgroundColor = .lightGray
    return iv
  }()
  
  private let textView : UITextView = {
    let tv = UITextView()
    tv.backgroundColor = .clear
    tv.font = .systemFont(ofSize: 16)
    tv.isScrollEnabled = false
    tv.isEditable = false
    tv.textColor = .white
    tv.text = "some test message"
    return tv
  }()
  
  private let bubbleContainer : UIView = {
    let view = UIView()
    view.backgroundColor = .systemPurple
    return view
  }()
  
  //MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(profileImageView)
    profileImageView.anchor(left : leftAnchor, bottom: bottomAnchor, paddingLeft: 8, paddingBottom: 4)
    profileImageView.setDimensions(height: 32, width: 32)
    profileImageView.layer.cornerRadius = 32 / 2
    
    addSubview(bubbleContainer)
    bubbleContainer.layer.cornerRadius = 12
    bubbleContainer.anchor(top : topAnchor, left: profileImageView.rightAnchor, paddingLeft: 12)
    bubbleContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
    
    bubbleContainer.addSubview(textView)
    textView.anchor(top : bubbleContainer.topAnchor, left: bubbleContainer.leftAnchor, right: bubbleContainer.rightAnchor, bottom: bubbleContainer.bottomAnchor, paddingTop: 4, paddingLeft: 12, paddingRight: -12, paddingBottom: -4)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
