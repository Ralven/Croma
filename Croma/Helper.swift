//
//  Helper.Swift
//  Croma
//
//  Created by Rafael Aguilera on 11/13/17.
//  Copyright © 2017 Rafael Aguilera. All rights reserved.
//

import Foundation
import Firebase
import Lottie

//MARK: Helper Functions
class Helper{
    // Helper Function to Upload image to Firebase Storage at a specific reference
    static func uploadToFirebaseStorage(data:NSData,reference: StorageReference){
        let uploadMetadata = StorageMetadata()
        uploadMetadata.contentType = "image/jpeg"
        reference.putData(data as Data, metadata: uploadMetadata, completion: { (metadata, error) in
            if error != nil{
                print("I recieved an error!")
            }else{
                print("Upload Complete!")
            }
        })
    }
    
    //Helper Function to Upload a User's Profile Picture
    static func uploadProfilePicture(data:NSData,user: User){
        let profileStorageReference = Storage.storage().reference(withPath: "user/\(user.getUserID())/profileimages/profilePicture.jpg")
        let uploadMetadata = StorageMetadata()
        uploadMetadata.contentType = "image/jpeg"
        profileStorageReference.putData(data as Data, metadata: uploadMetadata, completion: { (metadata, error) in
            if error != nil{
                print("I recieved an error!")
            }else{
                print("Upload Complete!")
            }
        })
    }
    
    // Helper function to make an imageview circular
    static func makeImageViewCircle(imageView: UIImageView){
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
    }
    
    static func makeButtonRounded(button:UIButton){
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
    }
    
    static func intToMoney(amount: Int) -> String.SubSequence{
        let numberString = "\(amount)"
        let suff = numberString.suffix(2)
        var result = numberString.dropLast(2)
        result += "." + suff
        return result
    }
    
}
