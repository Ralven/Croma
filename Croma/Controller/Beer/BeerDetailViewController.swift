//
//  BeerDetailViewController.swift
//  Croma
//
//  Created by Rafael Aguilera on 10/29/17.
//  Copyright © 2017 Rafael Aguilera. All rights reserved.
//

import UIKit
import Firebase
import Adyen

class BeerDetailViewController: UIViewController{
    
    //MARK: Properties
    var beer: Beer?
    var beerImage:UIImage?
    let storageRef = Storage.storage().reference()
    
    //MARK: Outlets
    @IBOutlet weak var styleLabel: UILabel!
    @IBOutlet weak var detailsImage: UIImageView!
    @IBOutlet weak var detailsText: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setBeerPicture()
        setBeerProperties()
    }
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier ?? "") {
        case "ShowBuy":
            print("ShowBuy segue taken")
            guard let purchaseViewController = segue.destination as? PurchaseViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            purchaseViewController.beer = beer
        default:
            print("default segue taken? Error")
        }
    }
    
    //MARK: Methods
    func setBeerPicture(){
        let reference = storageRef.child("beer").child((beer?.getName())!).child("photo").child(beer!.getPhotoName())
        reference.getData(maxSize: 10 * 1024 * 1024) { (data, error) -> Void in
            if (error != nil) {
                print(error!.localizedDescription)
            } else {
                let beerImage = UIImage(data: data!)
                self.detailsImage.image = beerImage
                print("– – – Succesfully downloaded the shared profile picture")
            }
        }
    }
    
    func setBeerProperties(){
        self.title = beer?.getName()
        detailsText.text = beer?.getBio()
        styleLabel.text = beer?.getStyle()
    }
    
    
}
