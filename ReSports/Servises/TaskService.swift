//
//  TaskService.swift
//  ReSports
//
//  Created by 志波大輝 on 2019/01/01.
//  Copyright © 2019 志波大輝. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage
import Nuke

protocol TaskServiceDelegate: class {
    func saved()
    func loaded()
}

class TaskService {
    static var shared = TaskService()
    private var events: [Event] = []
    
    // タスクを保存する役割を担っている
    // どこに保存するのかは分離している
    private var taskRepository: TaskRepositoryProtocol = FirestoreTaskRepository()
    
    weak var delegate: TaskServiceDelegate?
    
//    private init() {
//
//    }
    
    func getTask (at: Int) -> Event{
        return events[at]
    }
    
    func taskCount () -> Int{
        return events.count
    }
    
    // タスクの追加
    func addTask (_ task: Event) {
        events.append(task)
    }
    
    // タスクの削除
    func removeTask (at: Int) {
        //        tasks.remove(at: at)
        events[at].deleted = true
    }
    
    func reset () {
        events = []
    }
    
    func save () {
        taskRepository.save(events) {
            events = events.filter({ (task) -> Bool in
                return task.deleted == false
            })
            
            // デリゲートを使ってフックを作っている。保存したら実行
            self.delegate?.saved()
        }
    }
    
    func load() {
        taskRepository.load(completion: { (events) in
            self.events = events
            // デリゲートでフック。読み出したら実行
            self.delegate?.loaded()
        })
    }
    
    
    
    func saveImage(image: UIImage?, completion: @escaping (_ imageUrl: String?)->Void) {
        guard let image = image else {
            completion(nil)
            return
        }
        let storageRef = Storage.storage().reference()
        let currentTime = String(Int(NSDate().timeIntervalSince1970 * 100000))
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        print(currentTime)
        
        let dataRef = storageRef.child(currentTime + ".jpg")
        let data = image.jpegData(compressionQuality: 0.65)
        dataRef.putData(data!, metadata: metadata) { (metadata, error) in
            dataRef.downloadURL(completion: { (url, error) in
                guard let downloadUrl = url else {
                    completion(nil)
                    return
                }
                completion(downloadUrl.absoluteString)
            })
        }
    }
    
//    func loadImage(task: Event, imageView: UIImageView) {
//        guard let url = task.imageUrl else {
//            return
//        }
//        Nuke.loadImage(with: URL(string: url)!, into: imageView)
//    }
}
