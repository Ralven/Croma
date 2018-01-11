//
//  AddInfoViewController.swift
//  Croma
//
//  Created by Rafael Aguilera on 11/6/17.
//  Copyright © 2017 Rafael Aguilera. All rights reserved.
//

import UIKit
import Firebase

class AddInfoViewController: UIViewController {

    //MARK: Properties
    var beer:Beer?
    var beerBanner:NSData?
    var beerImage:NSData?
    
    //MARK: Outlets
    @IBOutlet weak var beerInfoTextView: UITextView!
    @IBOutlet weak var addBeerButton: UIButton!
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        Helper.makeButtonRounded(button: addBeerButton)
    }
    
    //MARK: Actions
    @IBAction func addBeerTap(_ sender: UIButton) {
        let bannerRef = Storage.storage().reference(withPath: "beer/\(beer?.getName() ?? "Default")/banner/\(beer?.getBannerName() ?? "Default")")
        let imageRef = Storage.storage().reference(withPath: "beer/\(beer?.getName() ?? "Default")/photo/\(beer?.getPhotoName() ?? "Default")")
        Helper.uploadToFirebaseStorage(data: beerBanner!, reference: bannerRef)
        Helper.uploadToFirebaseStorage(data: beerImage!, reference: imageRef)
        beer?.setDate(date: Date().description)
        beer?.setBio(bio: self.beerInfoTextView.text!)
        beer?.save()
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
