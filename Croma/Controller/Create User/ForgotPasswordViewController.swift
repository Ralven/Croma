//
//  ForgotPasswordViewController.swift
//  Croma
//
//  Created by Rafael Aguilera on 11/18/17.
//  Copyright © 2017 Rafael Aguilera. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var changePasswordButton: UIButton!
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        Helper.makeButtonRounded(button: changePasswordButton)
    }
    
    //MARK: Actions
    @IBAction func didTapChangePasswordButton(_ sender: UIButton) {
        Auth.auth().sendPasswordReset(withEmail: emailTextField.text!) { (error) in
            if error != nil{
                let errorAlert = UIAlertController(title: "Couldn't Send Email", message: error?.localizedDescription, preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in}))
                self.present(errorAlert, animated: true, completion: nil)
            }else{
                let confirmAlert = UIAlertController(title: "Password Reset", message: "An email has been sent to \(self.emailTextField.text!)", preferredStyle: .alert)
                confirmAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in}))
                self.present(confirmAlert, animated: true, completion: nil)
            }
        }
    }
    @IBAction func didTapCancel(_ sender: UIButton) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
