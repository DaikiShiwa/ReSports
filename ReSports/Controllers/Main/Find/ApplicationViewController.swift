//
//  ApplicationViewController.swift
//  ReSports
//
//  Created by 志波大輝 on 2019/01/12.
//  Copyright © 2019 志波大輝. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import PKHUD

class ApplicationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let db = Firestore.firestore()
    
    var selectedEvent: Event?
    var events: [Event] = []
    let sectionTitle:[String] = ["開催内容", "基本情報",  "地図", "備考"]
    var titleArray = [[String]]()
    var detailArray = [[String]]()
    var selectedSection = ""
    var selectedTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        if let selectedEvent = self.selectedEvent {
            self.title = "詳細画面"
            
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray[section].count
    }

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
    
    @IBAction func Applicationbutton(_ sender: Any) {
    }
    

}
