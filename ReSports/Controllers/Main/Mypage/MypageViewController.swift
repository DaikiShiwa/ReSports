//
//  MypageViewController.swift
//  ReSports
//
//  Created by 志波大輝 on 2019/01/14.
//  Copyright © 2019 志波大輝. All rights reserved.
//
import CoreLocation
import Eureka
import Firebase
import FBSDKLoginKit
import FirebaseFirestore

class MypageViewController: FormViewController {
    
    var MyName = ""
    var MyAge = ""
    var MyJender = ""
    var MyLocation = ""
    var MyHobby = ""

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    let user = User.shared
    
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
