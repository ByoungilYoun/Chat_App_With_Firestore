//
//  AuthService.swift
//  Chat_App_With_Firestore
//
//  Created by 윤병일 on 2021/02/28.
//

import UIKit
import Firebase

struct RegistrationCredentials {
  let email : String
  let password : String
  let fullname : String
  let username : String
  let profileImage : UIImage
}

struct AuthService {
  static let shared = AuthService()
  
  //MARK: - Function (logUserIn)
  func logUserIn(withEmail email : String, password : String, completion : AuthDataResultCallback?) {
    Auth.auth().signIn(withEmail: email, password: password, completion: completion)
  }
  
  //MARK: - Function (createUser)
  func createUser(credentials : RegistrationCredentials, completion : ((Error?) -> Void)?) {
    guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else {return}
    
    // storage 에 올라갈 이미지 저장 파일 이름 설정
    let fileName = NSUUID().uuidString
    let ref = Storage.storage().reference(withPath: "/profile_images/\(fileName)")
    
    // 서버에 업로드
    ref.putData(imageData, metadata: nil) { (meta, error) in
      if let error = error {
        print("Debug : Failed to upload image with error \(error.localizedDescription)")
        return
      }
      
      ref.downloadURL { (url, error) in
        guard let profileImageUrl = url?.absoluteString else {return}
        
        Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
          if let error = error {
            print("Debug : Failed to create user with error \(error.localizedDescription)")
            return
          }
          
          guard let uid = result?.user.uid else {return}
          
          let data = ["email" : credentials.email,
                      "fullname" : credentials.fullname,
                      "profileImageUrl" : profileImageUrl,
                      "uid" : uid,
                      "username" : credentials.username] as [String : Any]
          
          
          Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
          
        }
      }
    }
  }
}
