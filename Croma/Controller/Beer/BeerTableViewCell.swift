//
//  BeerTableViewCell.swift
//  Croma
//
//  Created by Rafael Aguilera on 10/29/17.
//  Copyright © 2017 Rafael Aguilera. All rights reserved.
//

import UIKit
import Firebase

class BeerTableViewCell: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var photoImageView: UIImageView!
    
    //MARK: Cell Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
