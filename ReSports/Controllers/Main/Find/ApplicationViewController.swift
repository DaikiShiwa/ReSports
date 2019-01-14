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
import MessageUI

class ApplicationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let db = Firestore.firestore()
    
    var selectedEvent: Event?
    var events: [Event] = []
    let sectionTitle:[String] = ["開催内容", "基本情報", "詳細情報"]
    var titleArray = [[String]]()
    var detailArray = [[String]]()
    var selectedSection = ""
    var selectedTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.register(UINib(nibName: "InfoCell", bundle: nil), forCellReuseIdentifier: "InfoCell")
        
        for _ in 0 ... 2{
            titleArray.append([])
        }
        titleArray[0] = ["開催名", "スポーツ種目"]
        titleArray[1] = ["開催日時", "プレイ時間", "レベル", "性別", "年齢", "応募期限"]
        titleArray[2] = ["住所", "備考"]

//        for _ in 0 ... 3{
//            detailArray.append([])
//        }
//        detailArray[0] = [loadEvents(completion: { (events) in
//            self.events = events
//        })]
//
//
//        if let selectedEvent = self.selectedEvent {
//            self.title = "詳細画面"
//            loadEvents(completion: { (events) in
//                self.events = events
//                self.tableView.reloadData()
//                HUD.hide()
//            })
//        }
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

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            //セルにテキストを出力する
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell") as! InfoCell
            //セルに表示する値（Labelの文字）を設定する
            cell.titleLabel?.text = self.titleArray[indexPath.section][indexPath.row]
//            cell.detailLabel?.text = self.detailArray[indexPath.section][indexPath.row]
        
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSection = sectionTitle[indexPath.section]
        selectedTitle = titleArray[indexPath.section][indexPath.row]
    }
    
    //メールアクション
    @IBAction func Applicationbutton(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["xxx@xxx.xxx"]) // 宛先アドレスはfirebaseから持ってきたい
            mail.setSubject("[ReSports]参加申込") // 件名
            mail.setMessageBody("ここに本文が入ります。", isHTML: false) // 本文
            present(mail, animated: true, completion: nil)
        } else {
            print("送信できません")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            print("キャンセル")
        case .saved:
            print("下書き保存")
        case .sent:
            print("送信成功")
        default:
            print("送信失敗")
        }
        dismiss(animated: true, completion: nil)
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

}
