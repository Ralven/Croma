//
//  PurchaseViewController.swift
//  Croma
//
//  Created by Rafael Aguilera on 11/17/17.
//  Copyright © 2017 Rafael Aguilera. All rights reserved.
//

import UIKit
import Firebase
import Adyen

class PurchaseViewController: UIViewController, CheckoutViewControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate {
    
    //MARK: Properties
    let saleOptions:[String] = ["6-Pack", "12-Pack", "18-Pack", "24-Pack", "Crate"]
    var beer:Beer? = nil
    var totalcalc:Int?
    var tempPriceHolder = 0
    var amount = 1
    var currentUser:String = "Default"
    
    //MARK: Outlets
    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var beerPickerView: UIPickerView!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        Helper.makeButtonRounded(button: checkoutButton)
        tempPriceHolder = (beer?.getPrice())!
        beerNameLabel.text = beer?.getName()
        totalLabel.text = "Price: \(Helper.intToMoney(amount: (beer?.getPrice())!))$"
        totalcalc = (beer?.getPrice())!
        currentUser = (Auth.auth().currentUser?.email)!
    }

    //MARK: Actions
    @IBAction func didTapCheckoutButton(_ sender: UIButton) {
        let viewController = CheckoutViewController(delegate: self)
        present(viewController, animated: true)
    }
    
    //MARK: Methods
    func checkoutViewController(_ controller: CheckoutViewController, requiresPaymentDataForToken token: String, completion: @escaping DataCompletion) {
        let paymentDetails: [String: Any] = [
            "amount": [
                "value": totalcalc!,
                "currency": "USD"
            ],
            "countryCode": "USA",
            "shopperReference": currentUser,
            "returnUrl": "my-shopping-app://", // URI Scheme.
            "channel": "ios",
            "token": token   // Pass the `token` received from SDK.
        ]
        // this is using test server must change later
        let url = URL(string: "https://checkoutshopper-test.adyen.com/checkoutshopper/demoserver/setup")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: paymentDetails, options: [])
        request.allHTTPHeaderFields = [
            "x-demo-server-api-key": "01013E8667EE5CD5932B441CFA2494937428A2F6BA589B5E21BF69157153D56CE6BA675B8EC26431D671151B4D2DD3D7EE4940B186E6C023754CE04501418B4CB010C15D5B0DBEE47CDCB5588C48224C6007", // Replace with my own Checkout API key.
            "Content-Type": "application/json"
        ]
        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { data, response, error in
            if let data = data {
                completion(data)
            }
            }.resume()
    }

    func checkoutViewController(_ controller: CheckoutViewController, requiresReturnURL completion: @escaping URLCompletion) {
        // Call `completion` when you receive the app's `openURL`.
        //        let openURL =     Get the app's `openURL`.
        //        completion(openURL)
    }

    func checkoutViewController(_ controller: CheckoutViewController, didFinishWith result: PaymentRequestResult) {
        controller.dismiss(animated: true, completion: nil)
    }
}

//extension for PickerView
extension PurchaseViewController{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return saleOptions.count
        }else{
            return 1000
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0{
            return saleOptions[row]
        }
        else{
            return "\(row+1)"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if component == 0{
            return NSAttributedString(string: saleOptions[row], attributes: [NSAttributedStringKey.foregroundColor:UIColor.white])
        }
        else{
            return NSAttributedString(string: "\(row+1)", attributes: [NSAttributedStringKey.foregroundColor:UIColor.white])
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0{
            tempPriceHolder = (beer?.getPrice())! * (row+1)
        }
        else{
            amount = row+1
        }
        totalcalc = tempPriceHolder*amount
        totalLabel.text = "Price: \(Helper.intToMoney(amount: tempPriceHolder*amount))$"
        
    }
    
}


