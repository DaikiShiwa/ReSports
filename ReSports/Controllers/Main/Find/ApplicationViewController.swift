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

class ApplicationViewController: UIViewController {
//, UITableViewDelegate, UITableViewDataSource
    @IBOutlet weak var tableView: UITableView!
    
    var selectedEvent: Event?
    var events: [Event] = []
    let sectionTitle:[String] = ["開催内容", "基本情報", "詳細情報"]
    var titleArray = [[String]]()
    var detailArray = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.delegate = self
//        tableView.dataSource = self
        
//        if let selectedEvent = self.selectedEvent {
//            self.title = "詳細画面"
//        }
    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
    
    @IBAction func Applicationbutton(_ sender: Any) {
    }
    

}
