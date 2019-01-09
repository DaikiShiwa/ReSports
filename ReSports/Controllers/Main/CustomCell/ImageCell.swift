//
//  ImageCell.swift
//  ReSports
//
//  Created by 志波大輝 on 2019/01/09.
//  Copyright © 2019 志波大輝. All rights reserved.
//

import UIKit

class ImageCell:UITableViewCell, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var todoImageview: UIImageView!
    
    var didChangedImage = false
    
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
        
//        self.present(alert, animated: true, completion: nil)
    }
    
    func presentPicker(SourceType: UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(SourceType){
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = SourceType
            cameraPicker.delegate = self
//            self.present(cameraPicker, animated: true, completion: nil)
        }else {
            print("The sourceType is not available")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[.originalImage] as? UIImage {
            todoImageview.contentMode = .scaleAspectFill
            todoImageview.image = pickedImage.resize(size: CGSize(width: 300, height: 200))
            didChangedImage = true
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
