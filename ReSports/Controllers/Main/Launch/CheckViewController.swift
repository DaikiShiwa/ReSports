//
//  CheckViewController.swift
//  ReSports
//
//  Created by 志波大輝 on 2019/01/02.
//  Copyright © 2019 志波大輝. All rights reserved.
//

import UIKit

class CheckViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    //左のラベル（title）に書く文字列
    let name1: [String] = ["開催名", "スポーツ種目"]
    let name2: [String] = ["開催日時", "プレイ時間", "募集人数", "応募者の条件", "応募期限"]
    let name3: [String] = ["地図", "写真", "備考"]
    
    //sectionのタイトル
    let sectionTitle: NSArray = ["開催内容", "基本情報", "詳細情報"]
    
    var eventsNameResultArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
//        self.tableView.register(UINib(nibName: "SampleCell2", bundle: nil), forCellReuseIdentifier: "SampleCell2")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if UserDefaults.standard.object(forKey: "eventsName") != nil {
            eventsNameResultArray = UserDefaults.standard.object(forKey: "eventsName") as! [String]
        }
            tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.row < 10 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell") as! InfoCell
            cell.titleLabel?.text = "開催名"
            cell.detailLabel?.text = eventsNameResultArray[indexPath.row]
            return cell
//        }
//        let cell = tableView.dequeueReusableCell(withIdentifier: <#T##String#>, for: <#T##IndexPath#>)
    }
    
//    // sectionの数を返す関数
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 3
//    }
//
//    // sectionごとのcellの数を返す関数
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0 {
//            return name1.count
//        } else if section == 1 {
//            return name2.count
//        } else if section == 2 {
//            return name3.count
//        } else {
//            return 0
//        }
//    }
//     // sectionに載せる文字列を返す関数
//     override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//         return sectionTitle[section] as? String
//     }
}
