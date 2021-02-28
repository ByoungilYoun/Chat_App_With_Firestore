//
//  UserCell.swift
//  Chat_App_With_Firestore
//
//  Created by 윤병일 on 2021/03/01.
//

import UIKit

class UserCell : UITableViewCell {
  
  //MARK: - Property
  private let profileImageView : UIImageView = {
    let iv = UIImageView()
    iv.backgroundColor = .systemPurple
    iv.contentMode = .scaleAspectFill
    iv.clipsToBounds = true
    return iv
  }()
  
  private let usernameLabel : UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 14)
    label.text = "spiderman"
    return label
  }()
  
  private let fullnameLabel : UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 14)
    label.textColor = .lightGray
    label.text = "Peter Parker"
    return label
  }()
  
  //MARK: - Lifecycle
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    addSubview(profileImageView)
    profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
    profileImageView.setDimensions(height: 56, width: 56)
    profileImageView.layer.cornerRadius = 56 / 2
    
    let stack = UIStackView(arrangedSubviews: [usernameLabel, fullnameLabel])
    stack.axis = .vertical
    stack.spacing = 2
    
    addSubview(stack)
    stack.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 12)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
