//
//  HomeViewModel.swift
//  Gender
//
//  Created by İbrahim Güler on 30.06.2023.
//

import SwiftUI

final class MainViewModel : ObservableObject {
    
    let imageDownloaderClient : ImageDownloaderClient = ImageDownloaderClient()
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
    
    @Published var randomPhoto : [Int: Image] = [:]
    @Published var userPhoto : [Int: Image] = [:]
    
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
    
    func userSelection(sense: SenseButtonType) {
        
        if let randomUser = self.randomUser {
            self.submitEffect = 1000
            self.updateUser(randomUserId: randomUser.id, sense: sense)
            self.getUser()
            
        }
        
    }
    
    private func updateUserInfo(id: String, sense: SenseButtonType) -> GenderUser {
        
        var user : GenderUser = GenderUser()

        user.id = self.currentUser.id
        
        if let name = self.currentUser.name {
            user.name = name
        }

        if let age = self.currentUser.age {
            user.age = age
        }
        
        if let birthDay = self.currentUser.birthDay {
            user.birthDay = birthDay
        }

        
        if let gender = self.currentUser.gender {
            user.gender = gender
        }
        
        if let interest = self.currentUser.interest {
            user.interest = interest
        }
        
        if let distance = self.currentUser.distance {
            user.distance = distance
        }
        
        if let wantLook = self.currentUser.wantLook {
            user.wantLook = wantLook
        }

        if let school = self.currentUser.school {
            user.school = school
        }
        
        if let isVisibleGender = self.currentUser.isVisibleGender {
            user.isVisibleGender = isVisibleGender
        }
        
        if let isVisibleOrientation = self.currentUser.isVisibleOrientation {
            user.isVisibleOrientation = isVisibleOrientation
        }

        user.defineUser = true
    
        if let orientation = self.currentUser.orientation {
            user.orientation = orientation
        }
        
        if let hobies = self.currentUser.hobies {
            user.hobies = hobies
        }
        
        if let photos = self.currentUser.photos  {
            user.photos = photos
        }

        if let likes = self.currentUser.likes  {
            user.likes = likes
        }
        if let dislike = self.currentUser.dislike  {
            user.dislike = dislike
        }
        if let superlike = self.currentUser.superlike  {
            user.superlike = superlike
        }
        
        switch(sense) {
        case .Like:
            user.likes?.append(id)
        case .DisLike:
            user.dislike?.append(id)
        case .SuperLike:
            user.superlike?.append(id)
        }

        
        return user
    }
    
   
    func updateUser(randomUserId : String?, sense: SenseButtonType?) {
        guard let id = randomUserId else { return }
        guard let sense = sense else { return }
        
        self.userData.AddUser(genderUser: self.updateUserInfo(id: id,sense: sense) ) { result in
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
                        imageDownloaderClient.downloadingImage(url: p, userStorage: userStorage) { result in
                            switch(result) {
                            case .failure(let fail):
                                print(fail)
                            case .success(let image):
                                print(image)
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
                                var id = 0
                                for photo in photos {
                                    if let p = photo {
                                        self.imageDownloaderClient.downloadingImage(url: p, userStorage: self.userStorage) { result in
                                            switch(result) {
                                            case .failure(let fail):
                                                print(fail)
                                            case .success(let image):
                                                print(image)
                                                self.userPhoto[id] = image
                                                id += 1
                                            }
                                        }
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
}

enum SenseButtonType : String, CaseIterable {
    case Like = "suit.heart.fill"
    case DisLike = "xmark"
    case SuperLike = "star.fill"
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


