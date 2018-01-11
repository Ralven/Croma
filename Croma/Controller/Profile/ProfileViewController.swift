//
//  ProfileViewController.swift
//  
//
//  Created by Rafael Aguilera on 11/2/17.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getProfilePicture()
        getUserInfo()
    }
    //MARK: Actions
    @IBAction func didTapLogOut(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "didLogOut", sender: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: \(signOutError)")
        }
    }
    
    //MARK: Methods
    func getProfilePicture(){
        let profileReference = Storage.storage().reference().child("user").child((Auth.auth().currentUser?.uid)!).child("profileimages").child("profilePicture.jpg")
        profileReference.getData(maxSize: 10 * 1024 * 1024) { (data, error) -> Void in
            if (error != nil) {
                print(error!.localizedDescription)
            } else {
                self.profilePicture.image = UIImage(data: data!)
                Helper.makeImageViewCircle(imageView: self.profilePicture)
                    print("– – – Succesfully downloaded the shared profile picture")
            }
        }
    }
    
    func getUserInfo(){
        let userID = Auth.auth().currentUser?.uid
        let userRef = Database.database().reference().child("users").child(userID!)
        userRef.observeSingleEvent(of: .value) { (snapshot) in
            let currentUser = User(snapshot: snapshot)
            self.fullNameLabel.text = "  Name: \(currentUser.getFullName())"
            self.emailLabel.text = "  Email: \(currentUser.getEmail())"
            self.ageLabel.text = "  Age: \(currentUser.getAge())"
        }
    }

}

//MARK: Style Overrides
extension ProfileViewController{
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
