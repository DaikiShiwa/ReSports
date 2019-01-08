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
import FirebaseFirestore

class FindViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.register(UINib(nibName: "EventCell", bundle: nil), forCellReuseIdentifier: "EventCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.row < 1 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell") as! SearchCell
//            cell.searchBar?.delegate = self as? UISearchBarDelegate
//            return cell
//        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell") as! EventCell
        let uid = User.shared.getUid()
        db.collection("users").document(uid!).collection("events").getDocuments{ (querySnapshot, error) in
            if let err = error {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
//                    cell.eventNameLabel?.text = document.data()
                }
            }
//            guard let value = snapShot else {
//                print("snapShot is nil")
//                return
//            }
//            value.documentChanges.forEach{diff in
//                if diff.type == .added {
//                    let eventData0p = diff.document.data() as? Dictionary<String, String>
//                    print(diff.document.data())
//                    guard let eventData = eventData0p else {
//                        return
//                    }
//                    guard let eventName = eventData["eventName"] else {
//                        return
//                    }
//                    guard let eventDay = eventData["eventDay"] else {
//                        return
//                    }
////                    let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell") as! EventCell
//                    cell.eventNameLabel?.text = "開催名"
//                    cell.eventDayLabel?.text = "開催日時"
//                    cell.eventImage?.image = UIImage(named: "ariake")
//                }
//
//            }
        }
        return cell
    }
//        cell.eventNameLabel?.text = ""
//        cell.eventDayLabel?.text = "開催日時"
//        cell.eventImage?.image = UIImage(named: "ariake")
//
//        return cell
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
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
