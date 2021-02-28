//
//  NewMessageController.swift
//  Chat_App_With_Firestore
//
//  Created by 윤병일 on 2021/02/28.
//

import UIKit

class NewMessageController : UITableViewController {
  
  //MARK: - Properties
  
  //MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  //MARK: - Helpers
  
  func configureUI() {
    view.backgroundColor = .systemPink
  }
}
