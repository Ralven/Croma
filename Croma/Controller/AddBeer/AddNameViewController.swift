//
//  AddNameViewController.swift
//  Croma
//
//  Created by Rafael Aguilera on 11/6/17.
//  Copyright © 2017 Rafael Aguilera. All rights reserved.
//

import UIKit

class AddNameViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Properties

    
    //MARK: Outlets
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var styleTextField: UITextField!
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setDelegates()
        Helper.makeButtonRounded(button: nextButton)
        // Do any additional setup after loading the view.
    }
    
    //MARK: Actions
    @IBAction func nextTap(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowBeerBanner", sender: nil)
    }
    
    @IBAction func cancelTap(_ sender: UIButton) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        if nameTextField.text != "" && styleTextField.text != ""{
            nextButton.isEnabled = true
            nextButton.alpha = 1
        }else{
            nextButton.isEnabled = false
            nextButton.alpha = 0.4
        }
    }
    
    //MARK: Methods
    func setDelegates(){
        self.nameTextField.delegate = self
        self.styleTextField.delegate = self
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier ?? "") {
        case "ShowBeerBanner":
            print("ShowBeerBanner segue taken")
            guard let addBannerViewController = segue.destination as? AddBannerViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            let beer = Beer(name: self.nameTextField.text!, banner: "", style: self.styleTextField.text!, bio: "", photo: "", date: "",price: 0)
            beer?.setName(name: self.nameTextField.text!)
            beer?.setStyle(style: self.styleTextField.text!)
            addBannerViewController.beer = beer
        default:
            print("default segue taken? Error")
        }
    }
    
}
