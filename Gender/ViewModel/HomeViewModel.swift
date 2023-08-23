//
//  HomeViewModel.swift
//  Gender
//
//  Created by İbrahim Güler on 30.06.2023.
//

import SwiftUI
import PhotosUI

class HomeViewModel : ObservableObject {
    
    private let userData : FirestoreProtocol = UserData()
    private let userConnection : AuthProtocol = UserConnection()
    private let userStorage : StorageProtocol = UserStorage()
    
    @Published var disLikeColor : Color = Color("DisLike")
    @Published var endColor : Color = Color("End")
    @Published var likeColor : Color = Color("Like")
    @Published var startColor : Color = Color("Start")
    @Published var superLikeColor : Color = Color("SuperLike")
    
    @Published var currentUser : GenderUser = GenderUser()
    @Published var randomUser : GenderUser?
    
    @Published var photoProgress = false
    
    @Published var rotationEffect : Double = 0
    @Published var submitEffect : Double = 0
    
    @Published var defineCount = 1
    
    @Published var name: String = ""
    
    @Published var defineBirthDay : [String] = ["","","/","","","/","","","",""]
    
    @Published var selectedGender = ""
    @Published var isVisibleGender = false
    
    @Published var selectedOrientation : [String] = []
    @Published var orientationTags: [String] = ["Heterosexual", "Heterosexual1", "Heterosexual2", "Heterosexual3", "Heterosexual4", "Heterosexual5", "Heterosexual6", "Heterosexual7", "Heterosexual8", "Heterosexual9", "Heterosexual10", "Heterosexual11", "Heterosexual12"]
    @Published var isVisibleOrientation = false
    
    @Published var selectedInterested = ""
    
    @Published var definePosition : CGPoint = CGPoint()
    
    @Published var selectedLook = ""
    
    @Published var selectedSchool = ""
    
    @Published var selectedHobiesList : [String] = []
    @Published var hobiesTags: [String] = ["Lorem", "Ipsum", "dolor", "consectetur", "adipiscing", "elit", "Nam", "semper", "sit", "amet", "ut", "eleifend", "Cras"]
    @Published var totalHeight = CGFloat.zero
    
    @Published var randomPhoto : [UIImage?] = []
    @Published var photoGestur : CGPoint = CGPoint()
    @Published var isGesturePosition: Bool = false
    @Published var photoId = 0
    
    @Published var photoList : [String] = []
    @Published var selectedPhoto : [Int: UIImage] = [:]
    @Published var showPicker: Bool = false
    
    @Published var users : [GenderUser] = []
    
    @Published var isConnected : Bool = false
    @Published var isLogin : Bool = true
    @Published var isFocused = false
    @Published var isProgress = false
    @Published var isProfile = false
    @Published var isSettings = false
    @Published var isStartSearched = false
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var likeList : [String] = []
    @Published var disLikeList : [String] = []
    @Published var superLikeList : [String] = []
    
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
            self.isConnected = false
            self.isProgress = false
            
        }
        
    }
    
    func loginUser() {
        
        if self.email != "" {
            if self.password != "" {
                
                self.isProgress = true
                
                DispatchQueue.main.async {
                    
                    self.userConnection.loginUser(email: self.email, password: self.password) { result in
                        switch result {
                            
                        case .failure(_):
                            
                            print("Hata !")
                            self.logoutUser()
                            self.isProgress = false
                            
                        case .success(_):
                            
                            self.isConnected = true
                            self.isProgress = false
                            
                            self.email = ""
                            self.password = ""
                            
                            
                        }
                        
                    }
                    
                }
                
            }
        }
        
    }
    
    func registerUser() {
        
        if self.email != "" {
            if self.password != "" {
                 
                DispatchQueue.main.async {
                     
                    self.userConnection.registerUser(email: self.email, password: self.password) { result in
                        switch result {
                            
                        case .failure(_):
                            
                            print("Hata !")
                            self.logoutUser()
                            self.isProgress = false
                            
                        case .success(_):
                            
                            self.addUser()
                            self.isConnected = true
                            self.isProgress = false
                            
                            self.email = ""
                            self.password = ""
                            
                        }
                    }
                    
                }
                
            }
        }
        
    }
    
    func addLikeList() {
        
        if let randomUser = self.randomUser {
            self.submitEffect = 1000
            self.likeList.append(randomUser.id)
            // self.updateUser()
            // self.getUser()
            
        }
        
    }
    
    func addDisLikeList() {
        
        if let randomUser = self.randomUser {
            self.submitEffect = 1000
            self.disLikeList.append(randomUser.id)
            // self.updateUser()
            // self.getUser()
            
        }
        
    }
    
    func addSuperLikeList() {
        
        if let randomUser = self.randomUser {
            self.submitEffect = 1000
            self.superLikeList.append(randomUser.id)
            // self.updateUser()
            // self.getUser()
            
        }
        
    }
    
    func changedGestureVlue(value : DragGesture.Value, proxy: GeometryProxy) {
        self.rotationEffect = -( self.photoGestur.x / 20)
        
        self.photoGestur.x = value.location.x - proxy.size.width / 2
        self.photoGestur.y = CGFloat(self.rotationEffect) + (proxy.size.height / 2)
    }
    
    func endGestureVlue() {
        if self.photoGestur.x <= -75 {
            self.addDisLikeList()
        } else if self.photoGestur.x >= 75 {
            self.addLikeList()
        }
        self.rotationEffect = 0
        self.photoGestur = .zero
    }
    
    func photoItulater(point: CGPoint) {
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
    
    func addUser() {
        appendUserData()
        
        self.userData.AddUser(genderUser: self.currentUser) { result in
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
    
    func updateUser() {
        getUsersData()
        defineUserConnection()
        appendUserData()
        
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
            self.randomPhoto = []
            if let photos = user.photos {
                for photo in photos {
                    if let p = photo {
                        self.userStorage.DownloadUserPhoto(url: p) { data in
                            if let data = data {
                                let image = UIImage(data: data)
                                self.randomPhoto.append(image)
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
                        
                        if let defineUser = user.defineUser {
                            if defineUser {
                                
                                if (self.currentUser.photos != []) {
                                    if let photos = self.currentUser.photos {
                                        self.selectedPhoto = [:]
                                        var k = 0
                                        for photo in photos {
                                            k += 1
                                            if let p = photo {
                                                self.downloadImage(p: p, index: k)
                                            }
                                        }
                                    }
                                }
                                
                                self.defineCount = 11
                                
                            } else {
                                
                                self.defineUserConnection()

                                guard let name = user.name else {
                                    self.isProgress = false
                                    self.defineCount = 1
                                    return
                                }

                                if name == "" {
                                    self.defineCount = 1
                                }
                                
                                guard let age = user.age else {
                                    self.isProgress = false
                                    self.defineCount = 2
                                    return
                                }

                                if age == "" {
                                    self.defineCount = 2
                                }
                                
                                guard let gender = user.gender else {
                                    self.isProgress = false
                                    self.defineCount = 3
                                    return
                                }

                                if gender == "" {
                                    self.defineCount = 3
                                }
                                
                                guard let interest = user.interest else {
                                    self.isProgress = false
                                    self.defineCount = 5
                                    return
                                }

                                if interest == "" {
                                    self.defineCount = 5
                                }
                                
                                guard let distance = user.distance else {
                                    self.isProgress = false
                                    self.defineCount = 6
                                    return
                                }

                                if distance == "" {
                                    self.defineCount = 6
                                }
                                
                                guard let wantLook = user.wantLook else {
                                    self.isProgress = false
                                    self.defineCount = 7
                                    return
                                }

                                if wantLook == "" {
                                    self.defineCount = 7
                                }
                                
                                guard let photos = user.photos else {
                                    self.isProgress = false
                                    self.defineCount = 10
                                    return
                                }
                                if photos.count < 2 {
                                    self.defineCount = 10
                                } else {
                                    self.defineCount = 11
                                }
                            }
                        }
                    }
                    
                    self.isProgress = false
                }
            }
        }
    }
    
    func defineUserConnection() {
        if let name = self.currentUser.name {
            self.name = name
        }

        
        if self.currentUser.birthDay != "" {
            if let birth = self.currentUser.birthDay {
                if let splitBirthDay = birth.split(separator: "") as? [String] {
                    self.defineBirthDay = splitBirthDay
                }
            }
        }
        
        if let gender = self.currentUser.gender {
            self.selectedGender = gender
        }

        
        
        if (self.currentUser.orientation != []) {
            if let orientations = self.currentUser.orientation {
                self.selectedOrientation = []
                for orientation in orientations {
                    if let o = orientation {
                        self.selectedOrientation.append(o)
                    }
                }
            }
        }
        
        if let interest = self.currentUser.interest {
            self.selectedInterested = interest
        }
        
        if let distance = self.currentUser.distance {
            if let distance = Int(distance) {
                self.definePosition.x = CGFloat(distance)
            }
        }
        
        if let wantLook = self.currentUser.wantLook {
            self.selectedLook = wantLook
        }
        
        if let school = self.currentUser.school {
            self.selectedSchool = school
        }
        
        if (self.currentUser.hobies != []) {
            if let hobies = self.currentUser.hobies {
                self.selectedHobiesList = []
                for hobie in hobies {
                    if let h = hobie {
                        self.selectedHobiesList.append(h)
                    }
                }
            }
        }
        
         
        if let visibleGender = self.currentUser.isVisibleGender {
            self.isVisibleGender = visibleGender
        }

        
        if let visibleOrientation = self.currentUser.isVisibleOrientation {
            self.isVisibleOrientation = visibleOrientation
        }
    
   
        if (self.currentUser.photos != []) {
            if let photos = self.currentUser.photos {
                self.selectedPhoto = [:]
                var k = 0
                for photo in photos {
                    k += 1
                    if let p = photo {
                        self.downloadImage(p: p, index: k)
                    }
                }
            }
        }
        
        if (self.currentUser.likes != []) {
            if let likes = self.currentUser.likes {
                self.likeList = []
                for like in likes {
                    if let l = like {
                        self.likeList.append(l)
                    }
                }
            }
        }
        
        if (self.currentUser.likes != []) {
            if let likes = self.currentUser.likes {
                self.likeList = []
                for like in likes {
                    if let l = like {
                        self.likeList.append(l)
                    }
                }
            }
        }
        
        if (self.currentUser.dislike != []) {
            if let dislike = self.currentUser.dislike {
                self.disLikeList = []
                for dis in dislike {
                    if let d = dis {
                        self.disLikeList.append(d)
                    }
                }
            }
        }
        
        if (self.currentUser.superlike != []) {
            if let superlike = self.currentUser.superlike {
                self.superLikeList = []
                for sup in superlike {
                    if let s = sup {
                        self.superLikeList.append(s)
                    }
                }
            }
        }

    }
    
    func downloadImage(p: String, index: Int) {
        self.photoProgress = true
        self.userStorage.DownloadUserPhoto(url: p) { data in
            if let data = data {
                let image = UIImage(data: data)
                self.selectedPhoto[index] = image
                self.photoProgress = false
            }
        }
    }
    
    func appendUserData(){
        self.currentUser.name = name
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        
        if let birthYear = Int(defineBirthDay[6] + defineBirthDay[7] + defineBirthDay[8] + defineBirthDay[9]) {
            let age = "\(year - birthYear)"
            self.currentUser.age = age
        }
        
        var birthDayStr = ""
        for birth in defineBirthDay {
            birthDayStr += birth
        }
        self.currentUser.birthDay = birthDayStr
        
        self.currentUser.gender = selectedGender
        self.currentUser.orientation = selectedOrientation
        self.currentUser.interest = selectedInterested
        self.currentUser.distance = "\(Int(definePosition.x))"
        self.currentUser.wantLook = selectedLook
        self.currentUser.school = selectedSchool
        
        self.currentUser.isVisibleGender = isVisibleGender
        self.currentUser.isVisibleOrientation = isVisibleOrientation
        if self.defineCount >= 11 {
            self.currentUser.defineUser = true
        }
        
        var num = 1
        for i in self.selectedPhoto {
            let img = i.value
                let data = img.jpegData(compressionQuality: 1)
                let url = "\(self.currentUser.id)/\(self.currentUser.id)\(num).jpg"
                
                self.userStorage.UploadUserPhoto(url: url, data: data)
                self.photoList.append(url)
            
            num += 1
        }
        
        
        self.currentUser.hobies = selectedHobiesList
        
        self.currentUser.photos = photoList
        self.currentUser.likes = likeList
        self.currentUser.dislike = disLikeList
        self.currentUser.superlike = superLikeList

    }
}
