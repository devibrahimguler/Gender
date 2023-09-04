//
//  ImageDownloaderClient.swift
//  Gender
//
//  Created by İbrahim Güler on 3.09.2023.
//

import SwiftUI

final class ImageDownloaderClient : ObservableObject {
    
    private let cache = NSCache<NSString, UIImage>()
    
    func downloadingImage(url :String, userStorage : StorageProtocol, complation: @escaping (Result<Image, DownloadError>) -> ()) {
        
        if let image = self.cache.object(forKey: url as NSString) {
            DispatchQueue.main.async {
                complation(.success(Image(uiImage: image)))
                return
            }
        }
        
        userStorage.DownloadUserPhoto(url: url) { data in
            DispatchQueue.main.async {
                guard let data = data else {
                    complation(.failure(.datahandler))
                    return
                }
                
                guard let image = UIImage(data: data) else {
                    complation(.failure(.notCash))
                    return
                }
                
                self.cache.setObject(image, forKey: url as NSString)
                complation(.success(Image(uiImage: image)))
            }
        }
        
    }
    
}

enum DownloadError : Error {
    case datahandler
    case notCash
}
