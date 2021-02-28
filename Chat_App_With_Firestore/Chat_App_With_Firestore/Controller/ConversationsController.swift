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
  
  //MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    configureNavigationBar()
    configureTableView()
    authenticateUser()
  }
  
  //MARK: - Selectors
  @objc func showProfile() {
    logout()
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
    
    let image = UIImage(systemName: "person.circle.fill")
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showProfile))
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
  
  func configureNavigationBar() {
    let appearance = UINavigationBarAppearance() // 네비게이션 바 백그라운드 appearance 생성
    appearance.configureWithOpaqueBackground()
    appearance.largeTitleTextAttributes = [.foregroundColor : UIColor.white] // 'Message' 타이틀 흰색으로 나타내기
    appearance.backgroundColor = .systemPurple
    
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.compactAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance
    
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.title = "Messages"
    
    navigationController?.navigationBar.tintColor = .white
    navigationController?.navigationBar.isTranslucent = true  // 반투명한
    
    navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
    
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
