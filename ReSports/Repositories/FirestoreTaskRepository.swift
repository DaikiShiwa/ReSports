//
//  FirestoreTaskRepository.swift
//  ReSports
//
//  Created by 志波大輝 on 2019/01/01.
//  Copyright © 2019 志波大輝. All rights reserved.
//

import Foundation
import FirebaseFirestore

class FirestoreTaskRepository: TaskRepositoryProtocol {
    
    let db = Firestore.firestore()
    
    init(){
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    }
    
    // ユーザー毎のデータベースへの参照を取得する
    private func getCollectionRef () -> CollectionReference {
        guard let uid = User.shared.getUid() else {
            fatalError ("Uidを取得出来ませんでした。")
        }
        return db.collection("users").document(uid).collection("tasks")
    }
    
    func save(_ tasks: [Event], completion: (() -> Void)) {
        // TODO トランザクション
        let collectionRef = getCollectionRef()
        tasks.forEach { (task) in
            
            if task.deleted{
                if let id = task.id {
                    let documentRef = collectionRef.document(id)
                    documentRef.setData(task.toData() as [String : Any])
                }
                return
            }
            if let id = task.id {
                let documentRef = collectionRef.document(id)
                documentRef.setData(task.toData() as [String : Any])
            } else {
                let documentRef = collectionRef.addDocument(data: task.toData() as [String : Any])
                task.id = documentRef.documentID
            }
        }
        // firestoreへの保存は非同期ではない（後でバックグラウンドで同期をしている？）
        completion()
    }
    
    func load(completion: @escaping (([Event]) -> Void)) {
        print ("データロード")
        var tasks: [Event] = [];
        let collectionRef = getCollectionRef()
        collectionRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print (error.localizedDescription)
            }else if let documents = querySnapshot?.documents {
                documents.forEach({ (document) in
                    if document.exists {
                        let data = document.data()
                        let task = Event(data: data)
                        task.id = document.documentID
                        tasks.append(task)
                    }
                })
            }
            // Firestoreからデータを読み込み終わったら
            // Firestoreの機能としてはデータが変更されたらというイベントもあるのでそちらも設定すると別端末で更新されたときにリアルタイムで更新ができる。
            completion(tasks)
        }
    }
}
