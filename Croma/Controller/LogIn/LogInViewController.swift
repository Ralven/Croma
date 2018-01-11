//
//  LogInViewController.swift
//  Croma
//
//  Created by Rafael Aguilera on 11/2/17.
//  Copyright © 2017 Rafael Aguilera. All rights reserved.
//

import UIKit
import Firebase

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Properties
    
    //MARK: Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginWindow: UIView!
    @IBOutlet weak var verifyLabel: UILabel!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var createNewAccountButton: UIButton!
    
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        Helper.makeButtonRounded(button: logInButton)
        Helper.makeButtonRounded(button: createNewAccountButton)
        
    }

    //MARK: Actions
    @IBAction func didTapLogIn(_ sender: UIButton) {
        if let email:String = emailTextField.text, let pass:String = passwordTextField.text{
            Auth.auth().signIn(withEmail: email, password: pass){
                (user,error) in
                if let error = error{
                    let alert = UIAlertController(title: "Couldn't Sign In", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in}))
                    self.present(alert, animated: true, completion: nil)
                }else{
                    self.performSegue(withIdentifier: "didLogIn", sender: nil)
                }
            }
        }
    }

    
    //MARK: Methods & Overrides
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

















