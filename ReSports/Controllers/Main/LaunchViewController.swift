//
//  LaunchViewController.swift
//  ReSports
//
//  Created by 志波大輝 on 2018/12/08.
//  Copyright © 2018 志波大輝. All rights reserved.
//

import CoreLocation
import Eureka

class LaunchViewController: FormViewController {
    
    var event = ""
    var sportsName = ""
    var eventDay = Date()
    var playTime = ""
    var memberCount = ""
    var applicant = ""
    var dueDay = Date()
    var location = ""
    
    static var dateFormat: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "yyyy/MM/dd/ h:mm a"

        return f
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        form +++
        //開催内容
             Section("開催内容")
            <<< TextRow(){
                $0.title = "開催名"
                $0.placeholder = "例：◯◯をしましょう！"
                $0.onChange{ [unowned self] row in
                    self.event = row.value ?? ""
                }
            }
            <<< AlertRow<String>(""){
                $0.title = "スポーツ種目"
                $0.selectorTitle = "スポーツを選択"
                $0.options = ["野球","テニス","フットサル","バスケットボール","バレーボール","ゴルフ","卓球","バドミントン","その他"]
                $0.value = "野球" //初期選択項目
                }.onChange{row in
                    self.sportsName = row.value ?? ""
//                    print(row.value as Any) //ここでアクションを行う
            }
        
        //基本情報
            +++ Section("基本情報")
            <<< DateTimeInlineRow() {
                $0.title = "開催日時"
                $0.dateFormatter = type(of: self).dateFormat
                $0.onChange{ [unowned self] row in
                    self.eventDay = row.value ?? Date()
                }
            }
            <<< ActionSheetRow<String>() {
                $0.title = "プレイ時間"
                $0.cancelTitle = "キャンセル"
                $0.selectorTitle = "プレイ時間"
                $0.options = ["１時間","２時間","３時間","４時間","５時間","６時間","７時間","８時間"]
                $0.value = "１時間"
                }.onChange { row in
                    self.playTime = row.value ?? ""
//                    print(row.value ?? "No Value")
                }
                .onPresent{ _, to in
                    to.view.tintColor = .orange
            }
            <<< PushRow<String>() {
                $0.title = "募集人数"
//                $0.options = []
//                for i in 1...10{
//                    $0.options?.append("\(i)")
//                }
                $0.options = ["１名","２名","３名","４名","５名","６名","７名","８名",]
                $0.value = ""
//                $0.selectorTitle = "指定なし"
                }.onPresent{ from, to in
                    to.dismissOnSelection = true
                    to.dismissOnChange = false
                }.onChange {row in
                    self.memberCount = row.value ?? ""
                }
            //場所（LocationRowの予定）
        
        
            
        
            <<< SwitchRow() {
                $0.title = "募集制限"
                $0.value = false
                $0.tag = "switch"
            }
        
        //募集制限
            +++ Section("募集制限") { section in
                section.hidden = Condition.function(["switch"] , { form in
                    return !((form.rowBy(tag: "switch") as? SwitchRow)?.value ?? false)
                })
            }
            <<< MultipleSelectorRow<String>() {
                $0.title = "応募者"
                $0.options = ["初心者","初級","初中級","中級","中上級","上級","男性","女性","10代","20代","30代","40代","50代","60代","70代〜"]
                }.onPresent { from, to in
                    to.sectionKeyForValue = { option in
                        switch option {
                        case "初心者","初級","初中級","中級","中上級","上級": return "レベル"
                        case "男性","女性": return "性別"
                        case "10代","20代","30代","40代","50代","60代","70代〜": return "年齢"
                        default: return ""
                        }
                    }
//                    to.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: from, action: #selector(RowsExampleViewController.multipleSelectorDone(_:)))
                }//応募者の属性をとりたい、、、
//                .onChange {row in
//                    self.applicant = row.value ?? ""
//                }
            
            <<< DateRow() {
                $0.title = "応募期限"
//                $0.dateFormatter = type(of: self).dateFormat
                $0.onChange{ [unowned self] row in
                    self.dueDay = row.value ?? Date()
                }
            }
        
        //「次へ」ボタン
        +++ Section()
            <<< ButtonRow() {
                $0.title = "次へ"
                $0.onCellSelection{ [unowned self] cell, row in
                    self.saveAll()
                    self.performSegue(withIdentifier: "showToAddViewController", sender: nil)
                }
        }
    }
    
    private func saveAll() {
        print("開催名", event)
        print("スポーツ種目", sportsName)
        print("開催日時", eventDay)
        print("プレイ時間", playTime)
        print("プレイ時間", memberCount)
        print("応募者", applicant)
        print("応募期限", dueDay)
    }
    
}

//enum SportsName: String {
//    case baseball = "野球"
//    case tennis = "テニス"
//    case futsal = "フットサル"
//    case basketball = "バスケットボール"
//    case volleyball = "バレーボール"
//    case golf = "ゴルフ"
//    case tabletennis = "卓球"
////    case bouldering = "ボルダリング"
//    case badminton = "バドミントン"
//    case others = "その他"
//}
