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
import PKHUD

class MypageViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var todoImageView: UIImageView!
    @IBOutlet weak var jenderLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var hobbyLabel: UILabel!
    
    let db = Firestore.firestore()
    var userdata:[UserData] = []
    var userprofile:UserData?
    
    // ユーザー毎のデータベースへの参照を取得する
    private func getCollectionRef () -> CollectionReference {
        guard let uid = User.shared.getUid() else {
            fatalError ("Uidを取得出来ませんでした。")
        }
        return db.collection("users").document(uid).collection("userdata")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoImageView.layer.cornerRadius = 55.0
        todoImageView.clipsToBounds = true
        
        loadUserData(completion: { (userdata) in
                self.userdata = userdata
                self.setup()
                HUD.hide()
        })

    }
    
    private func loadUserData(completion: @escaping (([UserData]) -> Void)) {
        HUD.show(.progress, onView: view)
        
        var userdata: [UserData] = [];
        let collectionRef = getCollectionRef()
        collectionRef.getDocuments { (querySnapshot, error) in
            if let err = error {
                print(err.localizedDescription)
            } else if let documents = querySnapshot?.documents {
                documents.forEach({ (document) in
                    if document.exists {
                        do {
                            let data = document.data()
                            let user = UserData(data: data)
                            user.id = document.documentID
                            userdata.append(user)
                        }
                    }
                })
            }
            completion(userdata)
        }
    }
    
    func setup() {
        nameLabel.text = userprofile?.myName
        jenderLabel.text = userprofile?.myJender
        ageLabel.text = "\(String(describing: userprofile?.myAge))歳"
        locationLabel.text = userprofile?.myLocation
        hobbyLabel.text = userprofile?.myHobby
        
//        let url = URL(string: userdata.myPhoto!)
    }
    
    
    @IBAction func didTouchEditButton(_ sender: Any) {
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
