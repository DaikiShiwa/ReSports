//
//  ReCheckViewController.swift
//  ReSports
//
//  Created by 志波大輝 on 2019/01/02.
//  Copyright © 2019 志波大輝. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource { // ‥①
    var myTableView1: UITableView!
    let textArry: [String] = [
        "1番めのセル","2番めのセル",
        "3番めのセルは長い文字列を設定して、\nセルの高さが自動的に調節されるようになるかを確認しようと思います。",
        "4番目のセル","5番目のセル"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView1 = UITableView(frame: self.view.frame, style: UITableViewStyle.grouped) // ‥②
        myTableView1.delegate = self // ‥③
        myTableView1.dataSource = self // ‥③
        myTableView1.estimatedRowHeight = 100
        myTableView1.rowHeight = UITableViewAutomaticDimension
        self.view.addSubview(myTableView1)
    }
    
    //④セクション数を指定
    func numberOfSections(in tableView: UITableView) -> Int {
        print("セクション数：1")
        return 1
    }
    //④セクションタイトルを指定
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "第\(section)セクション"
    }
    //④セル数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("セル数：5")
        return 5
    }
    //④セルを生成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("セルの値を入れていく")
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle,
                                   reuseIdentifier: "aaa\(indexPath.section)-\(indexPath.row)")
        cell.textLabel?.text = "セクション番号 : \(indexPath.section)"
        cell.detailTextLabel?.text = "行番号 : \(indexPath.row)"
        //cell.detailTextLabel?.numberOfLines = 0
        //cell.detailTextLabel?.text = textArry[indexPath.row]
        cell.imageView?.image = UIImage(named: "dog2.png")
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
