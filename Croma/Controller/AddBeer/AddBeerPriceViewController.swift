//
//  SetPticeViewController.swift
//  Croma
//
//  Created by Rafael Aguilera on 11/17/17.
//  Copyright © 2017 Rafael Aguilera. All rights reserved.
//

import UIKit

class AddBeerPriceViewController: UIViewController {

    //MARK: Properties
    var beer:Beer?
    var beerBanner:NSData?
    var beerImage:NSData?
    
    //MARK: Outlets
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        Helper.makeButtonRounded(button: nextButton)
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier ?? "") {
        case "ShowBeerInfo":
            print("ShowBeerInfo segue taken")
            guard let addInfoViewController = segue.destination as? AddInfoViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            addInfoViewController.beer = beer
            addInfoViewController.beerBanner = self.beerBanner
            addInfoViewController.beerImage = self.beerImage
        default:
            print("default segue taken? Error")
        }
    }
    
    //MARK: Actions
    @IBAction func editingEndPriceTextField(_ sender: Any) {
        beer?.setPrice(price: Int(priceTextField.text!)!)
    }
    

}
