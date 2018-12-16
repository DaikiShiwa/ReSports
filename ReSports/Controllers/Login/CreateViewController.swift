//
//  CreateViewController.swift
//  ReSports
//
//  Created by 志波大輝 on 2018/12/15.
//  Copyright © 2018 志波大輝. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController, UserDelegate, UITextFieldDelegate {

    let user = User.shared
  
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user.delegate = self
    }
    
    @IBAction func didTouchNewButton(_ sender: Any) {
        if let credential = getCredential() {
            user.create(credential: credential)
        }
    }
    
    @IBAction func didiTouchLoginButton(_ sender: Any) {
        if let credential = getCredential() {
            user.login(credential: credential)
        }
    }
    
    // delegate
    func didCreate(error: Error?) {
        if let error = error {
            self.alert("エラー", error.localizedDescription, nil)
            return
        }
        self.presentTaskList()
    }
    // delegate
    func didLogin(error: Error?) {
        if let error = error {
            print (error.localizedDescription)
            self.alert("エラー", error.localizedDescription, nil)
            return
        }
        self.presentTaskList()
    }
    
    func getCredential() -> Credential?{
        let email = emailTextField.text!
        let password = passwordTextField.text!
        if (email.isEmpty) {
            self.alert("エラー", "メールアドレスを入力して下さい", nil)
            return nil
        }
        if (password.isEmpty) {
            self.alert("エラー", "パスワードを入力して下さい", nil)
            return nil
        }
        return Credential(email: email, password: password)
    }
    
    func presentTaskList () {
        //Storyboardを指定
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "TabBarController")
        self.present(viewController, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        //キーボードを閉じる
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
}
