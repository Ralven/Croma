//
//  Beer.swift
//  Croma
//
//  Created by Rafael Aguilera on 10/29/17.
//  Copyright © 2017 Rafael Aguilera. All rights reserved.
//

import UIKit
import Firebase

class Beer {
    //MARK: Properties
    private var name:String = "Default"
    private var style:String = "Default"
    private var bannerName:String = "Default"
    private var bio:String = "Default"
    private var photoName:String = "Default"
    private var date:String = "Default"
    private var price:Int = 0
    private var beerReference:DatabaseReference?
    private var beerReferenceString:String = ""
    private var databaseReference = Database.database().reference().child("beer")
    
    //MARK: Initialization
    init?(name: String, banner: String, style: String, bio: String, photo: String, date:String, price: Int) {
        self.name = name
        self.bannerName = banner
        self.style = style
        self.bio = bio
        self.photoName = photo
        self.date = date
        self.price = price
        beerReference = Database.database().reference().child("beer").childByAutoId()
    }
    
    init(snapshot:DataSnapshot){
        databaseReference = snapshot.ref
        if let value = snapshot.value as? [String: Any]{
            name = value["name"] as! String
            bannerName = value["bannerName"] as! String
            bio = value["bio"] as! String
            photoName = value["photoName"] as! String
            style = value["style"] as! String
            date = value["date"] as! String
            price = value["price"] as! Int
            beerReferenceString = value["beerReference"] as! String
        }
    }
    
    //MARK: Methods
    func save(){
        self.beerReference?.setValue(["name": self.name, "style": self.style, "bannerName": self.bannerName, "bio": self.bio, "photoName": self.photoName, "date": self.date, "price": self.price, "beerReference": self.beerReference?.key as Any ])
    }
    
    func delete(){
        Database.database().reference().child("beer").child(beerReferenceString).removeValue { (error, databaseReference) in
            if error != nil{
                print("failed to delete beer")
                return
            }
        }
    }
    
    func toDictionary() -> [String:Any]{
        return [
            "name" : name,
            "style": style,
            "banner": bannerName+"Banner.jpg",
            "bio": bio,
            "photo": photoName+"Photo.jpg",
            "date": date,
            "price": price,
            "beerReference": beerReference!
        ]
    }
    
    //MARK: Getters
    func getName() -> String{return name}
    
    func getStyle() -> String{return style}
    
    func getBio() -> String{return bio}
    
    func getDate() -> String{return date}
    
    func getPhotoName() ->String{return photoName}
    
    func getBannerName() -> String{return bannerName}
    
    func getPrice() -> Int{return price}
    
    //MARK: Setters
    func setName(name:String){self.name = name}
    
    func setStyle(style: String){self.style = style}
    
    func setBio(bio: String){self.bio = bio}
    
    func setDate(date: String){self.date = date}
    
    func setPhotoName(photoName: String){self.photoName = photoName}
    
    func setBannerName(bannerName: String){self.bannerName = bannerName}
    
    func setPrice(price: Int){self.price = price}
}

