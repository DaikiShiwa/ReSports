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
    
    var eventsName = ""
    var sportsName = ""
    var eventDay = Date()
    var playTime = ""
    var memberCount = ""
    var level = ""
    var gender = ""
    var age = ""
    var dueDay = Date()
    var location = ""
    
    static var dateFormat: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "yyyy/MM/dd/ h:mm a"
        f.locale = Locale(identifier: "ja_JP")
        return f
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        form +++
        //開催内容
             Section("開催内容")
            <<< TextRow("eventsName"){
                $0.title = "開催名"
                $0.placeholder = "例：◯◯をしましょう！"
                $0.onChange{ [unowned self] row in
                    self.eventsName = row.value ?? ""
                }
            }
            <<< AlertRow<String>("sportsName"){
                $0.title = "スポーツ種目"
                $0.selectorTitle = "スポーツを選択"
                $0.options = ["野球","テニス","フットサル","バスケットボール","バレーボール","ゴルフ","卓球","バドミントン","その他"]
//                $0.value = "野球" //初期選択項目
                }.onChange{row in
                    self.sportsName = row.value ?? ""
            }
        
        //基本情報
            +++ Section("基本情報")
            <<< DateTimeInlineRow("eventDay") {
                $0.title = "開催日時"
                $0.dateFormatter = type(of: self).dateFormat
                $0.onChange{ [unowned self] row in
                    self.eventDay = row.value ?? Date()
                }
            }
            <<< ActionSheetRow<String>("playTime") {
                $0.title = "プレイ時間"
                $0.cancelTitle = "キャンセル"
                $0.selectorTitle = "プレイ時間"
                $0.options = ["１時間","２時間","３時間","４時間","５時間","６時間","７時間","８時間"]
//                $0.value = "１時間"
                }.onChange { row in
                    self.playTime = row.value ?? ""
//                    print(row.value ?? "No Value")
                }
                .onPresent{ _, to in
                    to.view.tintColor = .orange
            }
            <<< PushRow<String>("memberCount") {
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
            
            <<< SegmentedRow<String>("level") {
                $0.title = "レベル"
                $0.options = ["初心者","中級者","上級者"]
                }.onChange {row in
                    self.level = row.value ?? ""
            }
            
            <<< SegmentedRow<String>("gender") {
                $0.title = "性別"
                $0.options = ["男性","女性","選択しない"]
                }.onChange {row in
                    self.gender = row.value ?? ""
            }
            
            <<< MultipleSelectorRow<String>("age") {
                $0.title = "年齢"
                $0.options = ["10代","20代","30代","40代","50代","60代","70代〜"]
//                options.joined(separator: ", ")
//                }.onChange {row in
//                    self.age = row.value?.joined(separator: ", ") ??
//                    self.age = row.value ?? ""
            }
            
//            <<< MultipleSelectorRow<String>("applicant") {
//                $0.title = "応募者の条件"
//                $0.options = ["初心者","初級","初中級","中級","中上級","上級","男性","女性","10代","20代","30代","40代","50代","60代","70代〜"]
//                }.onPresent { from, to in
//                    to.sectionKeyForValue = { option in
//                        switch option {
//                        case "初心者","初級","初中級","中級","中上級","上級": return "レベル"
//                        case "男性","女性": return "性別"
//                        case "10代","20代","30代","40代","50代","60代","70代〜": return "年齢"
//                        default: return ""
//                        }
//                    }
////                    to.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: from, action: #selector(RowsExampleViewController.multipleSelectorDone(_:)))
//                }//応募者の属性をとりたい、、、
//                .onChange {row in
//                    self.applicant = row.value
//                }
            
            <<< DateRow("dueDay") {
                $0.title = "応募期限"
//                $0.dateFormatter = type(of: self).dateFormat
                $0.onChange{ [unowned self] row in
                    self.dueDay = row.value ?? Date()
                }
            }
        
        //「次へ」ボタン
        +++ Section()
            <<< ButtonRow("next") {
                $0.title = "次へ"
                $0.onCellSelection{ [unowned self] cell, row in
                    if (self.eventsName.isEmpty) {
                        self.showAlert("開催名を入力して下さい。")
                        return
                    }
//                    if (self.eventDay.isEmpty) {
//                        self.showAlert("開催日時を入力して下さい。")
//                        return
//                    }
                    self.saveAll()
                    self.performSegue(withIdentifier: "showToNextLaunchViewController", sender: nil)
                }
        }
    }
    
    private func saveAll() {
        //記入された内容を配列に入れて、アプリに保存する
        UserDefaults.standard.set(eventsName, forKey: "eventsName")
        UserDefaults.standard.set(sportsName, forKey: "sportsName")
        UserDefaults.standard.set(eventDay, forKey: "eventDay")
        UserDefaults.standard.set(playTime, forKey: "playTime")
        UserDefaults.standard.set(memberCount, forKey: "memberCount")
        UserDefaults.standard.set(level, forKey: "level")
        UserDefaults.standard.set(gender, forKey: "gender")
        UserDefaults.standard.set(age, forKey: "age")
        UserDefaults.standard.set(dueDay, forKey: "dueDay")
        
        print("開催名", eventsName)
        print("スポーツ種目", sportsName)
        print("開催日時", eventDay)
        print("プレイ時間", playTime)
        print("募集人数", memberCount)
        print("レベル", level)
        print("性別", gender)
        print("年齢", age)
        print("応募期限", dueDay)
    }
    
    func showAlert(_ text: String){
        let alertController = UIAlertController(title: "エラー", message: text , preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action) -> Void in
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
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
