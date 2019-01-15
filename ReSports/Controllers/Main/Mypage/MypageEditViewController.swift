//
//  MypageEditViewController.swift
//  ReSports
//
//  Created by 志波大輝 on 2019/01/16.
//  Copyright © 2019 志波大輝. All rights reserved.
//

import UIKit

class MypageEditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var genderSegmentControl: UISegmentedControl!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var hobbyTextField: UITextField!
    
    var pickerView: UIPickerView = UIPickerView()
    let locationlist = ["","北海道","青森県","岩手県","宮城県","秋田県","山形県","福島県",
                        "茨城県","栃木県","群馬県","埼玉県","千葉県","東京都","神奈川県",
                        "新潟県","富山県","石川県","福井県","山梨県","長野県","岐阜県",
                        "静岡県","愛知県","三重県","滋賀県","京都府","大阪府","兵庫県",
                        "奈良県","和歌山県","鳥取県","島根県","岡山県","広島県","山口県",
                        "徳島県","香川県","愛媛県","高知県","福岡県","佐賀県","長崎県",
                        "熊本県","大分県","宮崎県","鹿児島県","沖縄県"]
    
    var didChangedImage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ImageView.layer.cornerRadius = 55.0
        ImageView.clipsToBounds = true
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        self.view.addGestureRecognizer(tapRecognizer)

        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsSelectionIndicator = true
        
        let toolbar = UIToolbar(frame: CGRectMake(0, 0, 0, 35))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(MypageEditViewController.done))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(MypageEditViewController.cancel))
        toolbar.setItems([cancelItem, doneItem], animated: true)
        
        self.locationTextField.inputView = pickerView
        self.locationTextField.inputAccessoryView = toolbar
    }
    
    @IBAction func didTouchSaveButton(_ sender: Any) {
        print(nameTextField)
        print(locationTextField)
        print(ageTextField)
        print(hobbyTextField)
    }
    
    //都道府県ピッカー
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return locationlist[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locationlist.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.locationTextField.text = locationlist[row]
    }
    @objc func cancel() {
        self.locationTextField.text = ""
        self.locationTextField.endEditing(true)
    }
    @objc func done() {
        self.locationTextField.endEditing(true)
    }
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    
    //画面をタップすると、キーボードが閉じる動作
    @objc func tapGesture(sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        ageTextField.resignFirstResponder()
        locationTextField.resignFirstResponder()
        hobbyTextField.resignFirstResponder()
    }
    
    //画像イメージを保存する
        @IBAction func didTouchImageButton(_ sender: Any) {
            let alert = UIAlertController(title:"", message: "選択してください", preferredStyle: UIAlertController.Style.actionSheet)
            alert.addAction(UIAlertAction(title: "カメラ", style: UIAlertAction.Style.default, handler: {
                (action: UIAlertAction!) in
                print("カメラ")
                self.presentPicker(SourceType: .camera)
    
            }))
            alert.addAction(UIAlertAction(title: "アルバム", style: UIAlertAction.Style.default, handler: {
                (action: UIAlertAction!) in
                print("アルバム")
                self.presentPicker(SourceType: .photoLibrary)
            }))
            alert.addAction(UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: {
                (action: UIAlertAction!) in
                print("キャンセル")
            }))
    
            self.present(alert, animated: true, completion: nil)
        }
    
        func presentPicker(SourceType: UIImagePickerController.SourceType){
            if UIImagePickerController.isSourceTypeAvailable(SourceType){
                let cameraPicker = UIImagePickerController()
                cameraPicker.sourceType = SourceType
                cameraPicker.delegate = self
                self.present(cameraPicker, animated: true, completion: nil)
            }else {
                print("The sourceType is not available")
            }
        }
    
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
            if let pickedImage = info[.originalImage] as? UIImage {
                ImageView.contentMode = .scaleAspectFill
                ImageView.image = pickedImage.resize(size: CGSize(width: 110, height: 110))
                didChangedImage = true
            }
            picker.dismiss(animated: true, completion: nil)
        }
}
