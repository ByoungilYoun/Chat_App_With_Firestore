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
    Firestore.firestore().collection("users").getDocuments { (snapshot, error) in
      snapshot?.documents.forEach({ document in
        
        let dictionary = document.data()
        let user = User(dictionary: dictionary)
        users.append(user)
        completion(users)

      })
    }
  }
  
  static func uploadMessage(_ message : String, to user : User, completion : ((Error?) -> Void)?) {
    guard let currentUid = Auth.auth().currentUser?.uid else {return}
    
    // 저장될 data 형식
    let data = ["text" : message,
                "fromId" : currentUid,
                "toId" : user.uid,
                "timestamp" : Timestamp(date: Date())] as [String : Any]
    COLLECTION_MESSAGES.document(currentUid).collection(user.uid).addDocument(data: data) { _ in
      COLLECTION_MESSAGES.document(user.uid).collection(currentUid).addDocument(data: data, completion: completion)
    }
  }
}
