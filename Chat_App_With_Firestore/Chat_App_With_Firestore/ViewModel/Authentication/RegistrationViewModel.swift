//
//  RegistrationViewModel.swift
//  Chat_App_With_Firestore
//
//  Created by 윤병일 on 2021/02/25.
//

import Foundation

struct RegistrationViewModel : AuthenticationProtocol {
  
  var email : String?
  var password : String?
  var fullname : String?
  var username : String?
  
  var formIsValid : Bool {
    return email?.isEmpty == false
          && password?.isEmpty == false
          && fullname?.isEmpty == false
          && username?.isEmpty == false
  }
}
