//
//  Message.swift
//  Chat_App_With_Firestore
//
//  Created by 윤병일 on 2021/03/01.
//

import Foundation
import Firebase

struct Message {
  let text : String
  let toId : String
  let fromId : String
  var timestamp : Timestamp! // 시간
  var user : User? // 프로파일 이미지 url
  
  let isFromCurrentUser : Bool
  
  init(dictionary : [String : AnyObject]) {
    self.text = dictionary["text"] as? String ?? ""
    self.toId = dictionary["toId"] as? String ?? ""
    self.fromId = dictionary["fromId"] as? String ?? ""
    self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
    
    self.isFromCurrentUser = fromId == Auth.auth().currentUser?.uid
    
  }
}
