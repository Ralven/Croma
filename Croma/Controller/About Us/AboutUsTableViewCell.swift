//
//  AboutUsTableViewCell.swift
//  Croma
//
//  Created by Rafael Aguilera on 10/29/17.
//  Copyright © 2017 Rafael Aguilera. All rights reserved.
//

import UIKit

class AboutUsTableViewCell: UITableViewCell {

    //MARK: Outlets
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var personBio: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    
    //MARK: Cell Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: Actions
    @IBAction func personEmail(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "mailto:contato@cromabeer.com")! as URL, options: [:],completionHandler: nil)
    }

}
