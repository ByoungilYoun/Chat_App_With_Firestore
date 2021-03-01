//
//  MessageViewModel.swift
//  Chat_App_With_Firestore
//
//  Created by 윤병일 on 2021/03/01.
//

import UIKit

struct MessageViewModel {
  
  private let message : Message
  
  var messageBackgroundColor : UIColor {
    return message.isFromCurrentUser ? #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) : .systemPurple
  }
  
  var messageTextColor : UIColor {
    return message.isFromCurrentUser ? .black : .white
  }
  
  var rightAnchorActive : Bool {
    return message.isFromCurrentUser
  }
  
  var leftAnchorActive : Bool {
    return !message.isFromCurrentUser
  }
  
  var shouldHideProfileImage : Bool {
    return message.isFromCurrentUser
  }
  
  
  init(message : Message) {
    self.message = message
  }
}

