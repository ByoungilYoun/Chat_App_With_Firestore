//
//  Service.swift
//  Chat_App_With_Firestore
//
//  Created by 윤병일 on 2021/03/01.
//

import Foundation
import Firebase

struct Service {
  static func fetchUsers(completion : @escaping([User]) -> Void) {
    var users = [User]()
    COLLECTION_USERS.getDocuments { (snapshot, error) in
      snapshot?.documents.forEach({ document in
        
        let dictionary = document.data()
        let user = User(dictionary: dictionary)
        users.append(user)
        completion(users)

      })
    }
  }
  
  // func fetchUser  밑의 fetchConversations() 함수에서 user 를 가져와야해서 사용
  static func fetchUser(withUid uid : String, completion : @escaping(User) -> Void) {
    COLLECTION_USERS.document(uid).getDocument { (snapshot, error) in
      guard let dictionary = snapshot?.data() else {return}
      let user = User(dictionary: dictionary)
      completion(user)
    }
  }
  
  // func fetchConversations()
  static func fetchConversations(completion : @escaping([Conversation]) -> Void) {
    var conversations = [Conversation]()
    
    guard let uid = Auth.auth().currentUser?.uid else {return}
    
    let query = COLLECTION_MESSAGES.document(uid).collection("recent-messages").order(by: "timestamp")
    query.addSnapshotListener { (snapshot, error) in
      snapshot?.documentChanges.forEach({ change in
        let dictionary = change.document.data()
        let message = Message(dictionary: dictionary)
        
        self.fetchUser(withUid: message.toId) { user in
          let conversation = Conversation(user: user, message: message)
          conversations.append(conversation)
          completion(conversations)
        }
        
      })
    }
  }
  
  // func fetchMessages()
  static func fetchMessages(forUser user : User, completion : @escaping([Message]) -> Void) {
    var messages = [Message]()
    
    guard let currentUid = Auth.auth().currentUser?.uid else {return}
    
    let query = COLLECTION_MESSAGES.document(currentUid).collection(user.uid).order(by: "timestamp")
    
    query.addSnapshotListener { (snapshot, error) in
      snapshot?.documentChanges.forEach({ change in
        if change.type == .added {
          let dictionary = change.document.data()
          messages.append(Message(dictionary: dictionary))
          completion(messages)
        }
      })
    }
  }
  
  
  // func uploadMessage()
  static func uploadMessage(_ message : String, to user : User, completion : ((Error?) -> Void)?) {
    guard let currentUid = Auth.auth().currentUser?.uid else {return}
    
    // 저장될 data 형식
    let data = ["text" : message,
                "fromId" : currentUid,
                "toId" : user.uid,
                "timestamp" : Timestamp(date: Date())] as [String : Any]
    COLLECTION_MESSAGES.document(currentUid).collection(user.uid).addDocument(data: data) { _ in
      COLLECTION_MESSAGES.document(user.uid).collection(currentUid).addDocument(data: data, completion: completion) // addDocument 는 계속 정보를 쌓는다.
      
      COLLECTION_MESSAGES.document(currentUid).collection("recent-messages").document(user.uid).setData(data) // setData 는 정보를 최신걸로 override 한다
      
      COLLECTION_MESSAGES.document(user.uid).collection("recent-messages").document(currentUid).setData(data)
    }
  }
}
