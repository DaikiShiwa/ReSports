//
//  RemarksCell.swift
//  ReSports
//
//  Created by 志波大輝 on 2019/01/09.
//  Copyright © 2019 志波大輝. All rights reserved.
//

import UIKit

class RemarksCell:UITableViewCell, UITextViewDelegate {
    
    @IBOutlet weak var remarksTextView: UITextView!
    
    func viewDidLoad() {
        remarksTextView.delegate = self
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        self.addGestureRecognizer(tapRecognizer)
    }
    
    //画面をタップすると、キーボードが閉じる動作
    @objc func tapGesture(sender: UITapGestureRecognizer) {
        remarksTextView.resignFirstResponder()
    }
    
    @objc func commitButtonTapped() {
        remarksTextView.endEditing(true)
    }
    
    
}
