//
//  AddBannerViewController.swift
//  Croma
//
//  Created by Rafael Aguilera on 11/6/17.
//  Copyright © 2017 Rafael Aguilera. All rights reserved.
//

import UIKit

class AddBannerViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate {

    //MARK: Properties
    var beer:Beer?
    var beerBanner:NSData?
    
    //MARK: Outlets
    @IBOutlet weak var addBannerButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        beer?.setPhotoName(photoName: (beer?.getName())!+"Photo.jpg")
        beer?.setBannerName(bannerName: (beer?.getName())!+"Banner.jpg")
        Helper.makeButtonRounded(button: nextButton)
    }
    
    //MARK: Actions
    @IBAction func didTapAddBanner(_ sender: UIButton) {
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
    
    @IBAction func didTapNext(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowBeerImage", sender: nil)
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier ?? "") {
        case "ShowBeerImage":
            print("ShowBeerBanner segue taken")
            guard let addImageViewController = segue.destination as? AddImageViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            addImageViewController.beer = beer
            addImageViewController.beerBanner = self.beerBanner
        default:
            print("default segue taken? Error")
        }
    }
    
}

//MARK: UIImagePickerControllerDelegate Extension for AddBannerViewController
extension AddBannerViewController: UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.beerBanner = UIImageJPEGRepresentation(image, 0.0)! as NSData
        addBannerButton.setImage(image, for: .normal)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
