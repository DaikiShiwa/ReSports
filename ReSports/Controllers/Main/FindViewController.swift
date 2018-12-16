//
//  FindViewController.swift
//  ReSports
//
//  Created by 志波大輝 on 2018/12/08.
//  Copyright © 2018 志波大輝. All rights reserved.
//

import UIKit

class FindViewController: UIViewController {

    let user = User.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func didTouchLogoutButton(_ sender: Any) {
        user.logout()
        //Storyboardを指定
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        //Viewcontrollerを指定
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //rootViewControllerに入れる
        appDelegate.window?.rootViewController = initialViewController
    }
    
}
