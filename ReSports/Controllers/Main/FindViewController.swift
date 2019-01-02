//
//  FindViewController.swift
//  ReSports
//
//  Created by 志波大輝 on 2018/12/08.
//  Copyright © 2018 志波大輝. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit

class FindViewController: UIViewController {

    let user = User.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func didTouchLogoutButton(_ sender: Any) {
        //メールアドレスアカウントのログアウト
        user.logout()
        //Facebookアカウントのログアウト
        do {
            let loginManager = FBSDKLoginManager()
            loginManager.logOut() //Facebookログアウト
            try Auth.auth().signOut() // Firebaseログアウト
            print("👼 ログアウト完了")
        } catch let signOutError as NSError {
            print ("👿 Error signing out: %@", signOutError)
        }
        
        //Storyboardを指定
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        //Viewcontrollerを指定
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //rootViewControllerに入れる
        appDelegate.window?.rootViewController = initialViewController
    }
    
}
