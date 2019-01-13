//
//  DetailLaunchViewController.swift
//  ReSports
//
//  Created by 志波大輝 on 2019/01/10.
//  Copyright © 2019 志波大輝. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class DetailLaunchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,  UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    let sectionTitle:[String] = ["会場住所", "備考"]
    var titleArray = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        self.view.addGestureRecognizer(tapRecognizer)
        
        

        self.tableView.register(UINib(nibName: "MapViewCell", bundle: nil), forCellReuseIdentifier: "MapViewCell")
//        self.tableView.register(UINib(nibName: "ImageCell", bundle: nil), forCellReuseIdentifier: "ImageCell")
        self.tableView.register(UINib(nibName: "RemarksCell", bundle: nil), forCellReuseIdentifier: "RemarksCell")
        
        for _ in 0 ... 1{
            titleArray.append([])
        }
        titleArray[0] = ["地図"]
        titleArray[1] = ["テキストフィールド"]
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section < 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MapViewCell") as! MapViewCell
            cell.viewDidLoad()
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "RemarksCell") as! RemarksCell
        cell.viewDidLoad()
        return cell
    }
    
    //画面をタップすると、キーボードが閉じる動作
    @objc func tapGesture(sender: UITapGestureRecognizer) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RemarksCell") as! RemarksCell
        cell.remarksTextView.resignFirstResponder()
    }
    
    @objc func commitButtonTapped() {
        self.view.endEditing(true)
    }
    
    @IBAction func didTouchCheckButton(_ sender: Any) {
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "MapViewCell") as! MapViewCell
        let latitude = cell1.marker.position.latitude
        let longitude = cell1.marker.position.longitude
        UserDefaults.standard.set(latitude, forKey: "latitude")
        UserDefaults.standard.set(longitude, forKey: "longitude")
        
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "RemarksCell") as! RemarksCell
        let remarks = cell2.remarksTextView.text
        UserDefaults.standard.set(remarks, forKey: "remarks")
        
        print("緯度", latitude)
        print("経度", longitude)
        //        print("写真", imageUrl!)
        print("備考", remarks!)
    }
    
}
