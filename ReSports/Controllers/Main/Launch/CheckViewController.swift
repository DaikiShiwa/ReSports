//
//  CheckViewController.swift
//  ReSports
//
//  Created by 志波大輝 on 2019/01/02.
//  Copyright © 2019 志波大輝. All rights reserved.
//

import UIKit
import FirebaseFirestore

class CheckViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let db = Firestore.firestore()
    
    // ユーザー毎のデータベースへの参照を取得する
    private func getCollectionRef () -> CollectionReference {
        guard let uid = User.shared.getUid() else {
            fatalError ("Uidを取得出来ませんでした。")
        }
        return db.collection("users").document(uid).collection("events")
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    let sectionTitle:[String] = ["開催内容", "基本情報", "詳細情報"]
    var titleArray = [[String]]()
    var detailArray = [[String]]()
    var selectedSection = ""
    var selectedTitle = ""
    
    // UserDefaults のインスタンス
    let userDefaults = UserDefaults.standard
    
//    var eventsNameResultArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        for _ in 0 ... 2{
            titleArray.append([])
        }
        titleArray[0] = ["開催名", "スポーツ種目"]
        titleArray[1] = ["開催日時", "プレイ時間", "募集人数", "応募者の条件", "応募期限"]
        titleArray[2] = ["地図", "写真", "備考"]
        
        for _ in 0 ... 9{
            detailArray.append([])
        }
        detailArray[0] = [userDefaults.object(forKey: "eventsName") as! String,
                          userDefaults.object(forKey: "sportsName") as! String]
        detailArray[1] = [userDefaults.object(forKey: "eventsName") as! String,//eventDay
                          userDefaults.object(forKey: "playTime") as! String,
                          userDefaults.object(forKey: "memberCount") as! String,
                          userDefaults.object(forKey: "applicant") as! String,
                          userDefaults.object(forKey: "eventsName") as! String]//dueDay
        detailArray[2] = [userDefaults.object(forKey: "eventsName") as! String,
                          userDefaults.object(forKey: "eventsName") as! String,
                          userDefaults.object(forKey: "eventsName") as! String]
//        detailArray[1]
//        self.tableView.register(UINib(nibName: "infoSecondCell", bundle: nil), forCellReuseIdentifier: "infoSecondCell")
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
////        tableView.reloadData()
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.row < 10 {
            //セルにテキストを出力する
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell") as! InfoCell
            //セルに表示する値（Labelの文字）を設定する
            cell.titleLabel?.text = self.titleArray[indexPath.section][indexPath.row]
            cell.detailLabel?.text = self.detailArray[indexPath.section][indexPath.row]
        
            return cell
//        }
//        let cell = tableView.dequeueReusableCell(withIdentifier: , for: )
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSection = sectionTitle[indexPath.section]
        selectedTitle = titleArray[indexPath.section][indexPath.row]
    }
    
    @IBAction func registerButton(_ sender: Any) {
        let registerData: [String: Any] = ["開催名": userDefaults.object(forKey: "eventsName")!,
                                           "スポーツ種目": userDefaults.object(forKey: "sportsName")!,
                                           "開催日時": userDefaults.object(forKey: "eventDay")!,
                                           "プレイ時間": userDefaults.object(forKey: "playTime")!,
                                           "募集人数": userDefaults.object(forKey: "memberCount")!,
                                           "応募者の条件": userDefaults.object(forKey: "applicant")!]
        
        let uid = User.shared.getUid()
        db.collection("users").document(uid!).collection("events").addDocument(data: registerData)
        
        self.showAlert("")
        self.performSegue(withIdentifier: "showToLaunchViewController", sender: nil)
    }
    
    func showAlert(_ text: String){
        let alertController = UIAlertController(title: "開催内容が登録されました", message: text , preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action) -> Void in
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
