//
//  BeersTableViewController.swift
//  Croma
//
//  Created by Rafael Aguilera on 10/29/17.
//  Copyright © 2017 Rafael Aguilera. All rights reserved.
//

import UIKit
import Firebase

class BeersTableViewController: UITableViewController{
    
    //MARK: Properties
    let beersRef = Database.database().reference().child("beer")
    let usersRef = Database.database().reference().child("users")
    let storageRef = Storage.storage().reference()
    var beers = [Beer]()
    var admin:Bool = false

    var databaseHandle:DatabaseHandle?
    
    //MARK: Outlets
    @IBOutlet weak var addBeerButton: UIBarButtonItem!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewForCurrentUser()
        loadBeers()
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.reloadData()
    }

    //MARK: Actions
    @IBAction func addBeerTap(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "didAddBeer", sender: nil)
    }

    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
            case "ShowDetail":
                guard let beerDetailViewController = segue.destination as? BeerDetailViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }
                guard let selectedBeerCell = sender as? BeerTableViewCell else {
                    fatalError("Unexpected sender: \(String(describing: sender))")
                }
                guard let indexPath = tableView.indexPath(for: selectedBeerCell) else {
                    fatalError("The selected cell is not being displayed by the table")
                }
                let selectedBeer = beers[indexPath.row]
                beerDetailViewController.beer = selectedBeer
            case "didAddBeer":
                print("didAddBeer segue taken")
            default:
                print("default segue taken? Error")
        }
    }

    //MARK: Methods
    func setViewForCurrentUser(){
        if let user = Auth.auth().currentUser{
            print(user.uid)
            usersRef.child("\(user.uid)").observe(.value) { (snapshot) in
                let currentUser = User(snapshot: snapshot)
                if currentUser.getAdmin() == "true"{
                    self.admin = true
                    self.addBeerButton.tintColor = UIColor.white
                    self.addBeerButton.isEnabled = true
                }else{
                    self.admin = false
                    self.addBeerButton.tintColor = UIColor.clear
                    self.addBeerButton.isEnabled = false
                }
            }
        }
    }
    
    func loadBeers(){
        beersRef.observe(.value) { (snapshot) in
            self.beers.removeAll()
            for child in snapshot.children{
                let childSnapshot = child as! DataSnapshot
                let beer = Beer(snapshot: childSnapshot)
                self.beers.insert(beer, at: 0)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

//MARK: TableView Extension for BeersTableViewController
extension BeersTableViewController{
    //Makes sure you're admin before allowing Row Edit
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if self.admin{
            return true
        }else{
            return false
        }
    }
    //Edits Row if you are admin
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let beer = beers[indexPath.row]
        beer.delete()
        self.beers.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    //Number of Sections in TableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //Number of Rows per Section in Tableview
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beers.count
    }
    //Sets the Cells for the TableView
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "BeerTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? BeerTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        //Fetches the appropriate beer for the data source layout.
        let beer = beers[indexPath.row]
        let reference = storageRef.child("beer").child(beer.getName()).child("banner").child(beer.getBannerName())
        reference.getData(maxSize: 10 * 1024 * 1024) { (data, error) -> Void in
            if (error != nil) {
                print(error!.localizedDescription)
            } else {
                cell.photoImageView.image = UIImage(data: data!)
                print("– – – Succesfully downloaded the shared profile picture")
            }
        }
        return cell
    }
}

