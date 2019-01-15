//
//  MypageViewController.swift
//  ReSports
//
//  Created by 志波大輝 on 2019/01/14.
//  Copyright © 2019 志波大輝. All rights reserved.
//
import CoreLocation
import UIKit
import Firebase
import FBSDKLoginKit
import FirebaseFirestore

class MypageViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var todoImageView: UIImageView!
    @IBOutlet weak var jenderLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var hobbyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoImageView.layer.cornerRadius = 55.0
        todoImageView.clipsToBounds = true

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
