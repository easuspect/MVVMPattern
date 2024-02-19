//
//  ViewControllerModel.swift
//  MVCDesignPatternUygulama
//
//  Created by NewMac on 7/30/21.
//

import Foundation



protocol ViewControllerModelDelegate: AnyObject {
    func didUserFetch(_ users: [User])
}

class ViewControllerModel: NSObject {

    private var users: [User] = []

    weak var delegate: ViewControllerModelDelegate?

    func fetchUsers() {

        ApiRequestHandler.request { [weak self] result in
            switch result {
            case .success(let users):
                self?.users = users
                self?.delegate?.didUserFetch(users)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func retrieveUser(at index: Int) -> User {
        return users[index]
    }
}


































































