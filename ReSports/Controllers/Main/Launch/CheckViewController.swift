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
    
    @IBOutlet weak var tableView: UITableView!
    
    let sectionTitle:[String] = ["開催内容", "基本情報", "地図", "備考"]
    var titleArray = [[String]]()
    var detailArray = [[String]]()
    var selectedSection = ""
    var selectedTitle = ""
    
    // UserDefaults のインスタンス
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.register(UINib(nibName: "InfoCell", bundle: nil), forCellReuseIdentifier: "InfoCell")
        
        for _ in 0 ... 3{
            titleArray.append([])
        }
        titleArray[0] = ["開催名", "スポーツ種目"]
        titleArray[1] = ["開催日時", "プレイ時間", "レベル", "性別", "年齢", "応募期限"]
        titleArray[2] = ["地図"]
        titleArray[3] = ["備考"]
        
        for _ in 0 ... 3{
            detailArray.append([])
        }
        detailArray[0] = [userDefaults.object(forKey: "eventsName") as! String,
                          userDefaults.object(forKey: "sportsName") as! String]
        detailArray[1] = [userDefaults.object(forKey: "eventsName") as! String,//eventDay
                          userDefaults.object(forKey: "playTime") as! String,
//                          userDefaults.object(forKey: "memberCount") as! String,
                          userDefaults.object(forKey: "level") as! String,
                          userDefaults.object(forKey: "gender") as! String,
                          userDefaults.object(forKey: "age") as! String,
                          userDefaults.object(forKey: "eventsName") as! String]//dueDay
        detailArray[2] = [userDefaults.object(forKey: "eventsName") as! String]//latitude
//                          userDefaults.object(forKey: "eventsName") as! String]//longitude
        detailArray[3] = [userDefaults.object(forKey: "remarks") as! String]
//        detailArray[1]
//        self.tableView.register(UINib(nibName: "infoSecondCell", bundle: nil), forCellReuseIdentifier: "infoSecondCell")
    }
    
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
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 40
//    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section < 2 {
            //セルにテキストを出力する
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell") as! InfoCell
            //セルに表示する値（Labelの文字）を設定する
            cell.titleLabel?.text = self.titleArray[indexPath.section][indexPath.row]
            cell.detailLabel?.text = self.detailArray[indexPath.section][indexPath.row]
        
            return cell
        } else if indexPath.section < 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MapViewCell") as! MapViewCell
            cell.viewDidLoad()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RemarksCell") as! RemarksCell
            cell.viewDidLoad()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSection = sectionTitle[indexPath.section]
        selectedTitle = titleArray[indexPath.section][indexPath.row]
    }
    
    @IBAction func registerButton(_ sender: Any) {
        let registerData: [String: Any] = ["eventsName": userDefaults.object(forKey: "eventsName")!,
                                           "sportsName": userDefaults.object(forKey: "sportsName")!,
                                           "eventDay": userDefaults.object(forKey: "eventDay")!,
                                           "playTime": userDefaults.object(forKey: "playTime")!,
//                                           "memberCount": userDefaults.object(forKey: "memberCount")!,
                                           "level": userDefaults.object(forKey: "level")!,
                                           "gender": userDefaults.object(forKey: "gender")!,
                                           "age": userDefaults.object(forKey: "age")!,
                                           "dueDay": userDefaults.object(forKey: "dueDay")!,
                                           "latitude": userDefaults.object(forKey: "latitude")!,
                                           "longitude": userDefaults.object(forKey: "longitude")!,
//                                           "写真": userDefaults.object(forKey: "imageUrl")!,
                                           "remarks": userDefaults.object(forKey: "remarks")!]
        
//        let uid = User.shared.getUid()  .collection("users").document(uid!)
        db.collection("events").addDocument(data: registerData)
        
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
