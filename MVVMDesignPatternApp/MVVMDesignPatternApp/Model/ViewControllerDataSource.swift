//
//  ViewControllerDataSource.swift
//  MVCDesignPatternUygulama
//
//  Created by NewMac on 7/29/21.
//

import Foundation
import UIKit

class ViewControllerDataSource: NSObject {
    
    let userCell = "UserCell"
    var users = [User]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private weak var tableView: UITableView!
    private var vm: ViewControllerViewModel!
    
    init(tableView: UITableView, vm: ViewControllerViewModel) {
        super.init()
        self.tableView = tableView
        self.vm = vm
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.register(.init(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: userCell)
        
    }
}

extension ViewControllerDataSource {
    func updateData(with item: [User]) {
        users = item
    }
}



extension ViewControllerDataSource: UITableViewDelegate {
    
}

extension ViewControllerDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: userCell) as! UserCell
        let user = users[indexPath.row]
        cell.nameLabel.text = user.name
        cell.phoneNumberLabel.text = "Phone number : " + (user.phone ?? "N/A")
        cell.emailLabel.text = "Email : " + (user.email ?? "N/A")
        cell.userNameLabel.text = "Username : " + (user.username ?? "N/A")
        
        cell.contentView.backgroundColor = .systemBlue
        cell.containerView.backgroundColor = .white
        cell.containerView.layer.cornerRadius = 10
        cell.addressButtonPressed.backgroundColor = .orange
        cell.addressButtonPressed.layer.cornerRadius = 10
        cell.addressButtonPressed.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 5).cgColor
        cell.addressButtonPressed.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
        cell.addressButtonPressed.layer.shadowOpacity = 10.0
        cell.addressButtonPressed.layer.shadowRadius = 10.0
        cell.addressButtonPressed.layer.masksToBounds = false
        
        cell.delegate = self
        cell.indexPath = indexPath
        
        
        if user.isExpanded ?? false {
            
            cell.showRemoveButton.setImage(UIImage(named: "upArrow"), for: .normal)
            cell.containerViewHeightConstraint.isActive = false
            cell.phoneNumberLabel.isHidden = false
            cell.emailLabel.isHidden = false
            cell.userNameLabel.isHidden = false
        } else {
            cell.showRemoveButton.setImage(UIImage(named: "downArrow"), for: .normal)
            cell.containerViewHeightConstraint.isActive = true
            cell.phoneNumberLabel.isHidden = true
            cell.emailLabel.isHidden = true
            cell.userNameLabel.isHidden = true
        }
    
        cell.onClickExpandButton = { [weak self] in
            
            if (self?.users[indexPath.row].isExpanded ?? false) {
                self?.users[indexPath.row].isExpanded = false
            } else {
                self?.users[indexPath.row].isExpanded = true
            }
            
            self?.tableView.reloadRows(at: [indexPath], with: .automatic)
  
        }
        return cell
    }
  
}

extension ViewControllerDataSource: UserCellDelagate {
    func detailButtonPressed(_ indexPath: IndexPath) {
        vm.didNextButtonPress(at: indexPath.row)
    }
}

struct UserCellViewModel {
    let phoneNumber: String
    let username: String
    let email: String
    let isExpanded: Bool
}
