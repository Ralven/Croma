//
//  AddImageViewController.swift
//  Croma
//
//  Created by Rafael Aguilera on 11/6/17.
//  Copyright © 2017 Rafael Aguilera. All rights reserved.
//

import UIKit

class AddImageViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate{
    
    //MARK: Properties
    var beer:Beer?
    var beerBanner:NSData?
    var beerImage:NSData?
    
    //MARK: Outlets
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        Helper.makeButtonRounded(button: nextButton)
    }
    
    //MARK: Actions
    @IBAction func nextTap(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowBeerInfo", sender: nil)
    }
    
    @IBAction func addImageButtonTap(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier ?? "") {
        case "ShowBeerPrice":
            print("ShowBeerInfo segue taken")
            guard let addBeerPriceViewController = segue.destination as? AddBeerPriceViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            addBeerPriceViewController.beer = beer
            addBeerPriceViewController.beerBanner = self.beerBanner
            addBeerPriceViewController.beerImage = self.beerImage
        default:
            print("default segue taken? Error")
        }
    }

}

//MARK: UIImagePickerControllerDelegate Extension for AddBannerViewController
extension AddImageViewController: UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.beerImage = UIImageJPEGRepresentation(image, 0.0)! as NSData
        addImageButton.setImage(image, for: .normal)
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
