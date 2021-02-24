//
//  LoginViewModel.swift
//  Chat_App_With_Firestore
//
//  Created by 윤병일 on 2021/02/24.
//

import Foundation

protocol AuthenticationProtocol {
  var formIsValid : Bool { get }
}

struct LoginViewModel : AuthenticationProtocol {
  var email : String?
  var password : String?
  
  var formIsValid : Bool {
    return email?.isEmpty == false && password?.isEmpty == false
  }
}
