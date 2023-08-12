//
//  UserStorage.swift
//  Gender
//
//  Created by İbrahim Güler on 10.08.2023.
//

import FirebaseStorage
import SwiftUI

protocol StorageProtocol {
    func UploadUserPhoto(id: String, photonum: String, data: Data?)
    func DownloadUserPhoto(url: String, complation : @escaping (Data?)-> ()) 
}

struct UserStorage : StorageProtocol {
    let storage = Storage.storage()
    
    func UploadUserPhoto(id: String, photonum: String, data: Data? ) {
        let ref = storage.reference().child("\(id)/\(id + photonum).jpg")
        if let data = data {
            ref.putData(data, metadata: nil) { metaData, error in
                guard error == nil else { return }
                
                guard metaData == nil else { return }
            }
        }
    }
    
    func DownloadUserPhoto(url: String, complation : @escaping (Data?)-> ()) {
        let ref = storage.reference().child(url)
        ref.getData(maxSize: 1 * 1024 * 1024) { data, err in
            guard err == nil else { return }
            complation(data)
        }
    }
}
