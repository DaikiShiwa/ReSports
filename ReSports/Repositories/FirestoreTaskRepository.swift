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
    
    func save(_ tasks: [Task], completion: (() -> Void)) {
        
    }
    
    func load(completion: @escaping (([Task]) -> Void)) {
        
    }
    
    
}
