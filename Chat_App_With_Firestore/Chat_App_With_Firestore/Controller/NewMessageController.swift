//
//  NewMessageController.swift
//  Chat_App_With_Firestore
//
//  Created by 윤병일 on 2021/02/28.
//

import UIKit

private let reuseIdentifier = "UserCell"

class NewMessageController : UITableViewController {
  
  //MARK: - Properties
  private var users = [User]()
  
  //MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    fetchUsers()
  }
  
  //MARK: - Selector
  @objc func handleDismissal() {
    dismiss(animated: true, completion: nil)
  }
  
  //MARK: - API
  func fetchUsers() {
    Service.fetchUsers { users in
      self.users = users
      self.tableView.reloadData() // reloadData 를 해야한다. 처음 users 변수는 아무것도 없다가 complete 될때까지(API 호출을 사용해서 데이터를 가져오는데) 시간이 좀 걸리니까 리로드를 해줘야한다.
    }
  }
  //MARK: - Helpers
  
  func configureUI() {
    configureNavigationBar(withTitle: "New Message", prefersLargeTitle: false)

    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleDismissal))
    
    tableView.tableFooterView = UIView()
    tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
    tableView.rowHeight = 80
  }
}

  //MARK: - UITableViewDataSource
extension NewMessageController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return users.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
    return cell
  }
}
