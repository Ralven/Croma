//
//  WelcomeViewController.swift
//  Croma
//
//  Created by Rafael Aguilera on 11/17/17.
//  Copyright © 2017 Rafael Aguilera. All rights reserved.
//

import UIKit
import Lottie

class WelcomeViewController: UIViewController {

    //MARL: Properties
    var cromaAnimation:LOTAnimationView?
    var welcomeAnimation:LOTAnimationView?
    
    //MARK: Outlets
    @IBOutlet weak var cromaAnimationView: UIView!
    @IBOutlet weak var continueButton: UIButton!
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        showAnimation(animation: cromaAnimation, view: cromaAnimationView, animationName: "LogoAnimation")
        continueButton.layer.cornerRadius = 20
        continueButton.clipsToBounds = true
        
        
    }
    
    //MARK: Methods
    func showAnimation(animation: LOTAnimationView?, view: UIView,animationName: String){
        let animation = LOTAnimationView.init(name: animationName)
        animation.isUserInteractionEnabled = true
        animation.frame = view.frame
        animation.contentMode = .scaleAspectFill
        self.view.addSubview(animation)
        animation.play()
    }
    



}
