//
//  UserCell.swift
//  MVCDesignPatternUygulama
//
//  Created by NewMac on 7/29/21.
//

import UIKit

protocol UserCellDelagate: AnyObject{
    func detailButtonPressed(_ indexPath: IndexPath)
}

class UserCell: UITableViewCell {
    
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet var containerViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var addressButtonPressed: UIButton!
    @IBOutlet weak var showRemoveButton: UIButton!
    
    
    var onClickExpandButton: (() -> ())?
    weak var delegate: UserCellDelagate?
    var indexPath: IndexPath!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func showRemoveButtonPressed(_ sender: Any) {
        onClickExpandButton?()
    }
    
    @IBAction func detailButtonPressed(_ sender: Any) {
        delegate?.detailButtonPressed(indexPath)
    }
    
}
