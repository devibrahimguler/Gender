//
//  HomeViewModel.swift
//  Gender
//
//  Created by İbrahim Güler on 30.06.2023.
//

import SwiftUI

final class HomeViewModel : ObservableObject {
    
    let userData : FirestoreProtocol = UserData()
    let userConnection : AuthProtocol = UserConnection()
    let userStorage : StorageProtocol = UserStorage()
    
    @Published var currentUser : GenderUser = GenderUser()
    @Published var randomUser : GenderUser?
    
    @Published var rotationEffect : Double = 0
    @Published var submitEffect : Double = 0
    
    @Published var photoId : Int = 0
    @Published var photoGestur : CGPoint = .zero
    
    @Published var users : [GenderUser] = []
    
    @Published var isProgress : Bool = false
    @Published var isConnected : Bool = false
    
    @Published var isProfile : Bool = false
    @Published var isSettings : Bool = false
    @Published var isStartSearched : Bool = false
    @Published var photoProgress : Bool = false
    @Published var defineUser : Bool = false
    
    @Published var randomPhoto : [Int: UIImage] = [:]
    @Published var userPhoto : [Int: UIImage] = [:]
    
    init() {
        
        if let id = self.userConnection.getUid {
            
            self.isConnected = true
            self.currentUser.id = id
            self.getUsersData()
            
        }
    }
    
    func logoutUser() {
        self.isProgress = true
        DispatchQueue.main.async {
            
            self.userConnection.logout()
            self.isProfile = false
            self.isConnected = false
            self.isProgress = false
            
        }
        
    }
    
    func userSelection(selection: LoveChoice) {
        
        if let randomUser = self.randomUser {
            self.submitEffect = 1000
            self.updateUser(randomUserId: randomUser.id, loveChoice: selection)
            self.getUser()
            
        }
        
    }
    
    func changedGestureValue(value : DragGesture.Value, proxy: GeometryProxy) {
        self.rotationEffect = -( self.photoGestur.x / 20)
        
        self.photoGestur.x = value.location.x - proxy.size.width / 2
        self.photoGestur.y = CGFloat(self.rotationEffect) + (proxy.size.height / 2)
    }
    
    func endGestureValue() {
        if self.photoGestur.x <= -75 {
            self.userSelection(selection: .DisLike)
        } else if self.photoGestur.x >= 75 {
            self.userSelection(selection: .Like)
        }
        self.rotationEffect = 0
        self.photoGestur = .zero
        
    }
    
    func getUserPhotos(point: CGPoint) {
        if point.x > 191 && point.y < 344 {
            if (self.randomPhoto.count - 1) > self.photoId {
                self.photoId += 1
            }
        } else if point.x < 191 && point.y < 344 {
            if self.photoId >= 0 {
                self.photoId -= 1
            }
        }
        
    }
    
    func updateUser(randomUserId : String?, loveChoice: LoveChoice?) {
        
        self.userData.AddUser(genderUser: self.currentUser ) { result in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: .init(block: {
                switch result {
                case .failure(let error):
                    print(error)
                case.success(let succ):
                    print(succ)
                    
                }
            }))
        }
        
    }
    
    func getUser() {
        var number = 0
        if self.users.count >= 1 {
            number = Int.random(in: 0..<self.users.count)
        }
        
        self.randomUser = self.users[number]
        
        if let user = self.randomUser {
            self.photoId = 0
            var id = 0
            self.randomPhoto = [:]
            if let photos = user.photos {
                for photo in photos {
                    if let p = photo {
                        self.userStorage.DownloadUserPhoto(url: p) { data in
                            if let data = data {
                                let image = UIImage(data: data)
                                self.randomPhoto[id] = image
                                id += 1
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    func getUsersData() {
        
        self.isProgress = true
        userData.FetchData { result in
            switch result{
            case .failure(_):
                print("Hata!")
                self.isProgress = false
            case .success(let data):
                if let data = data {
                    self.users = data
                    
                    if let user = self.users.filter({ user in user.id == self.currentUser.id}).first {
                        self.currentUser = user
                        
                        if user.defineUser != nil {
                            self.defineUser = true
                        }
                        
                        if (self.currentUser.photos != []) {
                            if let photos = self.currentUser.photos {
                                self.userPhoto = [:]
                                var k = 0
                                for photo in photos {
                                    k += 1
                                    if let p = photo {
                                        self.downloadImage(p: p, index: k)
                                    }
                                }
                            }
                        }
                    }
                    
                    self.isProgress = false
                }
            }
        }
    }
    
    func downloadImage(p: String, index: Int) {
        self.photoProgress = true
        self.userStorage.DownloadUserPhoto(url: p) { data in
            if let data = data {
                let image = UIImage(data: data)
                self.userPhoto[index] = image
                self.photoProgress = false
            }
        }
    }
}

enum LoveChoice {
    case Like
    case DisLike
    case SuperLike
}

/*
 protocol HomeViewModelProtocol : ObservableObject {
     var userData : FirestoreProtocol {get}
     var userConnection : AuthProtocol {get}
     var userStorage : StorageProtocol {get}
     
     var currentUser : GenderUser  {get}
     var randomUser : GenderUser? {get}
     
     var rotationEffect : Double  {get}
     var submitEffect : Double  {get}
     
     var photoId : Int  {get}
     var photoGestur : CGPoint  {get}
     
     var users : [GenderUser]{get}
     
     var isProgress : Bool {get}
     var isConnected : Bool{get}
     
     var isProfile : Bool {get}
     var isSettings : Bool{get}
     var isStartSearched : Bool{get}
     var photoProgress : Bool {get}
     var defineUser : Bool {get}
     
     var randomPhoto : [Int: UIImage] {get}
     var userPhoto : [Int: UIImage] {get}
     
     func logoutUser()
     func userSelection(selection: LoveChoice)
     func changedGestureValue(value : DragGesture.Value, proxy: GeometryProxy)
     func endGestureValue()
     func getUserPhotos(point: CGPoint)
     func updateUser(randomUserId : String?, loveChoice: LoveChoice?)
     func getUser()
     func getUsersData()
     func downloadImage(p: String, index: Int)
 }
 */


