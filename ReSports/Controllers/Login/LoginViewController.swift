//
//  LoginViewController.swift
//  ReSports
//
//  Created by 志波大輝 on 2018/12/14.
//  Copyright © 2018 志波大輝. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate{
    
//    let user = User.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        //ログイン済みかチェック
//        if let _ = FBSDKAccessToken.current() {
//            //画面遷移
//            performSegue(withIdentifier: "modalTop", sender: self)
//        }else{
//            //FBログインボタン設置
//            let fbLoginBtn = FBSDKLoginButton()
//            fbLoginBtn.readPermissions = ["public_profile", "email"]
//            fbLoginBtn.center = self.view.center
//            fbLoginBtn.delegate = self
//            self.view.addSubview(fbLoginBtn)
//        }
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        // ログイン済みかチェック
        if let token = FBSDKAccessToken.current() {
            let credential = FacebookAuthProvider.credential(withAccessToken: token.tokenString)
            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                if error != nil {
                    // ...
                    return
                }
                // ログイン時の処理
            }
//            self.presentTaskList()
            return
        }
    }
    
    //Facebookボタン
    @IBAction func FacebookLoginButton(_ sender: Any) {
        let loginManager = FBSDKLoginManager()
        loginManager.logIn(withReadPermissions: ["email", "public_profile"], from: self, handler: { (result, error) in
            if let error = error {
                print("👿1 \(error.localizedDescription)")
            } else if result!.isCancelled {
                print("FBLogin cancelled")
            } else {
                // `FacebookAuthProvider`⬅️これはFirebaseの方のクラス。こいつがFacebookのトークンをつかってFirebaseの認証用のトークンを作っている
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                // `Auth`もFirebaseのクラス。⬆️のcredentialをつかってFirebaseにログインしている
                Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                    if let error = error {
                        print("👿2 \(error.localizedDescription)")
                        // ここでエラーコードは確認出来る https://firebase.google.com/docs/reference/swift/firebaseauth/api/reference/Enums/AuthErrorCode
                        print("👿2 \(error._code)")
                        return
                    }
                    print("👼 ログイン完了")
                    self.presentTaskList()
                }
            }
        })
    }
    
    //メールアドレスボタン
    @IBAction func logindidTouchButton(_ sender: UIButton) {
        print("飛んでるよ")
    }
    
    //ログインコールバック（Facebook）
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("飛んでるよ")
        
        if error != nil {
            print("Error")
            return
        }
        // ログイン時の処理
    }
    
//    @IBAction func logoutButton(_ sender: Any) {
//        let firebaseAuth = Auth.auth()
//        do {
//            try firebaseAuth.signOut()
//        } catch let signOutError as NSError {
//            print ("Error signing out: %@", signOutError)
//        }
//    }
    
    // ログアウトのコールバック（Facebook）
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User signed out")
    }
    
    func presentTaskList () {
        //Storyboardを指定
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "TabBarController")
        self.present(viewController, animated: true, completion: nil)
    }
    
//    //delegate
//    func didCreate(error: Error?) {
//        if let error = error {
//            self.alert("エラー", error.localizedDescription, nil)
//            return
//        }
//        self.presentTaskList()
//    }
//    func didLogin(error: Error?) {
//        if let error = error {
//            print (error.localizedDescription)
//            self.alert("エラー", error.localizedDescription, nil)
//            return
//        }
//        self.presentTaskList()
//    }
    
//    @IBAction func didTouchAnonymouslyLoginButton(_ sender: Any) {
//        Auth.auth().signInAnonymously() {
//            (user, error) in
//            if error == nil {
//                print("UserId: \(user?.uid)")
//                let newUser = Database.database().reference().child("users").child((user?.uid)!)
//                newUser.setValue(["displayname": "anonymous", "id":"/\(user?.uid)", "profileUrl" : ""])
//            }
//        }
    
//        guard let name = nameField.text else {
//            return
//        }
//        
//        Auth.auth().signInAnonymously(completion: { [weak self] (user, error) in
//            if let e = error {
//                //アラート表示とか
//                return
//            }
//
//            //匿名サインインに成功したので、名前を更新する
//            let request = user?.profileChangeRequest()
//            request?.displayName = name
//            request?.commitChanges(completion: { (error) in
//                if let e2 = error {
//                    //アラート表示とか
//                    return
//                }
//
//                // サインイン完了、ホーム画面へ遷移させたりする
//                self?.nameLabel.text = user?.displayName
//            })
//        })
//    }
    
    
}
