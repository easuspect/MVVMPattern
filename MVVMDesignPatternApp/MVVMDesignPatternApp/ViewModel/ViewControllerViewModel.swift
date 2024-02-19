//
//  ViewControllerViewModel.swift
//  MVVMDesignPatternApp
//
//  Created by NewMac on 8/1/21.
//

import Foundation

protocol ViewControllerViewModelDelegate: AnyObject {
    
    func updateTable(with users: [User])
}

class ViewControllerViewModel {
    
    private let model = ViewControllerModel()
    private let router = ViewControllerRouter()
    weak var delegate: ViewControllerViewModelDelegate?
    
    func notifyViewLoaded() {
        model.delegate = self
        model.fetchUsers()
    }
    
    func didNextButtonPress(at index: Int) {
        let user = model.retrieveUser(at: index)
        router.navigateToDetailPage(user: user)
    }
}

extension ViewControllerViewModel: ViewControllerModelDelegate {
    
    func didUserFetch(_ users: [User]) {
        delegate?.updateTable(with: users)
    }
}

