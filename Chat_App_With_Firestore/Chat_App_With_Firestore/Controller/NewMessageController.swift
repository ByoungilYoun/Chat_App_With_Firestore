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
  
  //MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  //MARK: - Selector
  @objc func handleDismissal() {
    dismiss(animated: true, completion: nil)
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
    return 2
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
    return cell
  }
}
