//
//  CreateUserViewController.swift
//  Croma
//
//  Created by Rafael Aguilera on 11/2/17.
//  Copyright © 2017 Rafael Aguilera. All rights reserved.
//

import UIKit
import Firebase

class CreateUserViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate{
    
    //MARK: Properties
    var profileStorageReference = Storage.storage().reference()
    var uploadImage:NSData?
    var userID:String?
    
    //MARK: Outlets
    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var uploadImageButton: UIButton!
    @IBOutlet weak var ageValueTextField: UITextField!
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        Helper.makeImageViewCircle(imageView: uploadImageButton.imageView!)
        setTextFieldDelegates()
    }
    
    //MARK: Actions
    @IBAction func didTapCancel(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapSave(_ sender: Any) {
        if !(fullnameTextField.text?.isEmpty)! && !(ageValueTextField.text?.isEmpty)! && !(emailTextField.text?.isEmpty)! && !(passwordTextField.text?.isEmpty)! {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                if let error = error{
                    let alert = UIAlertController(title: "Couldn't Create User", message: "\(error.localizedDescription) no spaces allowed in email", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in}))
                    self.present(alert, animated: true, completion: nil)
                }
                if let user = user {
                    //create new user to save with information entered after auth check
                    let newUser = User(fullname: self.fullnameTextField.text!,email: user.email!, age:self.ageValueTextField.text!,userID: user.uid)
                    newUser?.save()
                    //email authentification
                    user.sendEmailVerification { (error) in
                        
                    }
                    if self.uploadImage != nil{
                        Helper.uploadProfilePicture(data: self.uploadImage!, user: newUser!)
                    }
                    
                    self.performSegue(withIdentifier: "didCreateUser", sender: nil)
                }
            }
            
        }else{
            let alert = UIAlertController(title: "Can't Save", message: "Must Fill All Fields To Save", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in}))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func didTapUploadImage(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
            }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        ageValueTextField.text = "\(Int(sender.value))"
    }

    //MARK: Methods
    func setTextFieldDelegates(){
        fullnameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

}

//MARK: Extension for UIImagePickerControllerDelegate
extension CreateUserViewController: UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.uploadImage = UIImageJPEGRepresentation(image, 0.0)! as NSData
        uploadImageButton.setImage(image, for: .normal)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
