//
//  Person.swift
//  Croma
//
//  Created by Rafael Aguilera on 10/29/17.
//  Copyright © 2017 Rafael Aguilera. All rights reserved.
//

import UIKit
import Firebase


class User {
    //MARK: Properties
    private var fullname:String?
    private var email:String?
    private var age:String?
    private var userID:String?
    private var admin:String = "false"
    private let databaseReference: DatabaseReference!
    
    //MARK: Initialization
    init?(fullname: String?, email: String?,age: String?,userID: String?) {
        self.fullname = fullname
        self.email = email
        self.age = age
        self.userID = userID
        self.admin = "false"
        databaseReference = Database.database().reference().child("users").child("\(self.userID!)")
    }
    
    init(snapshot:DataSnapshot){
        databaseReference = snapshot.ref
        if let value = snapshot.value as? [String: Any]{
            fullname = value["fullname"] as? String
            email = value["email"] as? String
            age = value["age"] as? String
            admin = value["admin"] as! String
            userID = value["userID"] as? String
        }
    }
    
    //MARK: Methods
    func save(){
        databaseReference.setValue(["email": self.email, "fullname": self.fullname, "age": self.age, "admin": "false", "userID": self.userID])
        //ref.setValue(["email": self.email, "fullname": self.fullname, "age": self.age, "admin": "false", "userID": self.userID])
    }
    
    func toDictionary() -> [String:Any]{
        return [
            "name" : fullname!,
            "email": email!,
            "age": age!,
            "admin": admin,
            "userID": userID!
        ]
    }
    
    //MARK: Getters
    func getFullName() -> String{if fullname != nil{return fullname!}else{return "Default"}}
    
    func getEmail() -> String{if email != nil{return email!}else{return "Default"}}
    
    func getAge() -> String{if age != nil{ return age!}else{return "Default"}}
    
    func getAdmin() -> String{return admin}
    
    func getUserID() -> String{return userID!}
    
    //MARK: Setters
    func setFullName(fullname: String?){self.fullname = fullname}
    
    func setEmail(email: String?){self.email = email}
    
    func setAge(age: String?) {self.age = age}
    
    func setUserID(userID: String?){self.userID = userID}
    
}
