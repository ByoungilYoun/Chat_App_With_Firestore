//
//  ConversationsController.swift
//  Chat_App_With_Firestore
//
//  Created by 윤병일 on 2021/02/17.
//

import UIKit
import Firebase

private let reuseIdentifier = "ConversationCell"

class ConversationsController : UIViewController {
  //MARK: - Properties
  private let tableView = UITableView()
  
  // 플러스 버튼
  private let newMessageButton : UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(systemName: "plus"), for: .normal)
    button.backgroundColor = .systemPurple
    button.tintColor = .white
    button.imageView?.setDimensions(height: 24, width: 24)
    button.addTarget(self, action: #selector(showNewMessage), for: .touchUpInside)
    return button
  }()
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    authenticateUser()
  }
  
  //MARK: - Selectors
  @objc func showProfile() {
    logout()
  }
  
  // 플러스 버튼에 addTarget
  @objc func showNewMessage() {
    let controller = NewMessageController()
    controller.delegate = self
    let nav = UINavigationController(rootViewController: controller)
    nav.modalPresentationStyle = .fullScreen
    present(nav, animated: true, completion: nil)
    
  }
  //MARK: - API
  // 로그인 되어있으면 ConversationController로 이동, 로그인이 안되어있으면 LoginController 로 이동.
  func authenticateUser() {
    if Auth.auth().currentUser?.uid == nil {
      print("Debug : User is not logged in. Present login screen here..")
      presentLoginScreen()
    } else {
      print("Debug : User id is \(Auth.auth().currentUser?.uid).")
    }
  }
  
  // 로그아웃
  func logout() {
    do {
      try Auth.auth().signOut()
      presentLoginScreen()
    } catch {
      print("Debug : Error signing out...")
    }
  }
  
  //MARK: - Helpers
  // 로그인뷰컨 띄우는 함수
  func presentLoginScreen() {
    DispatchQueue.main.async {
      let controller = LoginController()
      let nav = UINavigationController(rootViewController: controller)
      nav.modalPresentationStyle = .fullScreen
      self.present(nav, animated: true, completion: nil)
    }
  }
  
  
  func configureUI() {
    view.backgroundColor = .systemBackground
    
    configureNavigationBar(withTitle: "Messages", prefersLargeTitle: true)
    configureTableView()
    
    
    let image = UIImage(systemName: "person.circle.fill")
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showProfile))
    
    view.addSubview(newMessageButton)
    newMessageButton.setDimensions(height: 56, width: 56)
    newMessageButton.layer.cornerRadius = 56 / 2
    newMessageButton.anchor(right : view.rightAnchor ,bottom : view.safeAreaLayoutGuide.bottomAnchor, paddingRight: -30, paddingBottom: -16)
    
  }
  
  func configureTableView() {
    tableView.backgroundColor = .white
    tableView.rowHeight = 80
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    tableView.tableFooterView = UIView()
    tableView.delegate = self
    tableView.dataSource = self
    
    view.addSubview(tableView)
    tableView.frame = view.frame
  }
}

//MARK: - UITableViewDataSource
extension ConversationsController : UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
    cell.textLabel?.text = "Test Cell"
    return cell
  }
}

  //MARK: - UITableViewDelegate
extension ConversationsController : UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(indexPath.row)
  }
}

  //MARK: - NewMessageControllerDelegate
extension ConversationsController : NewMessageControllerDelegate {
  func controller(_ controller: NewMessageController, wantsToStartChatWith user: User) {
    controller.dismiss(animated: true, completion: nil)
    let chat = ChatController(user: user)
    navigationController?.pushViewController(chat, animated: true)
  }
}
