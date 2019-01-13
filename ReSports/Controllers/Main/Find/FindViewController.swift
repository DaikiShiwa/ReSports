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
import PKHUD

class FindViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let db = Firestore.firestore()
    
    var events: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
            
        self.tableView.register(UINib(nibName: "EventCell", bundle: nil), forCellReuseIdentifier: "EventCell")
        
        loadEvents(completion: { (events) in
            self.events = events
            self.tableView.reloadData()
            HUD.hide()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
        cell.setup(with: self.events[indexPath.row])
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let applicationViewController = storyboard?.instantiateViewController(withIdentifier: "ApplicationViewController") as! ApplicationViewController
//        applicationViewController.
        
    }
    
    private func loadEvents(completion: @escaping (([Event]) -> Void)) {
        HUD.show(.progress, onView: view)
        
        var events: [Event] = [];
        let collectionRef = db.collection("events")
        collectionRef.getDocuments { (querySnapshot, error) in
            if let err = error {
                print(err.localizedDescription)
            } else if let documents = querySnapshot?.documents {
                documents.forEach({ (document) in
                    if document.exists {
                        do {
                            let data = document.data()
                            let event = Event(data: data)
                            event.id = document.documentID
                            events.append(event)
                        }
                    }
                })
            }
            completion(events)
        }
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
