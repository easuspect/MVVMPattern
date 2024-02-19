//
//  ViewController.swift
//  MVCDesignPatternUygulama
//
//  Created by NewMac on 7/29/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var dataSource: ViewControllerDataSource!
    private var vm = ViewControllerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        vm.notifyViewLoaded()
    }
}

extension ViewController {
    
    func setupUI() {
        vm.delegate = self
        dataSource = .init(tableView: tableView, vm: vm)
    }
}

extension ViewController: ViewControllerViewModelDelegate {

    func updateTable(with users: [User]) {
        dataSource.updateData(with: users)
    }
}
