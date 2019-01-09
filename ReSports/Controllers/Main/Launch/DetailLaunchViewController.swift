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

class DetailLaunchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    let sectionTitle:[String] = ["会場住所", "イベントトップ画像", "備考"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        self.view.addGestureRecognizer(tapRecognizer)

        self.tableView.register(UINib(nibName: "MapViewCell", bundle: nil), forCellReuseIdentifier: "MapViewCell")
        self.tableView.register(UINib(nibName: "ImageCell", bundle: nil), forCellReuseIdentifier: "ImageCell")
        self.tableView.register(UINib(nibName: "RemarksCell", bundle: nil), forCellReuseIdentifier: "RemarksCell")
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MapViewCell") as! MapViewCell
            cell.viewDidLoad()
//            cell.addressLabel =
            return cell
        }; if indexPath.row < 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell") as! ImageCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RemarksCell") as! RemarksCell
            return cell
        }
    }
    
    //画面をタップすると、キーボードが閉じる動作
    @objc func tapGesture(sender: UITapGestureRecognizer) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RemarksCell") as! RemarksCell
        cell.remarksTextView.resignFirstResponder()
    }
    
    @IBAction func didTouchCheckButton(_ sender: Any) {
        
//        let latitude = self.marker.position.latitude
//        let longitude = self.marker.position.longitude
//        UserDefaults.standard.set(latitude, forKey: "latitude")
//        UserDefaults.standard.set(longitude, forKey: "longitude")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RemarksCell") as! RemarksCell
        let remarks = cell.remarksTextView.text
        UserDefaults.standard.set(remarks, forKey: "remarks")
        
//        print("緯度", latitude)
//        print("経度", longitude)
        //        print("写真", imageUrl!)
        print("備考", remarks!)
    }
    
}
