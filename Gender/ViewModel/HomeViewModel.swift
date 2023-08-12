//
//  HomeViewModel.swift
//  Gender
//
//  Created by İbrahim Güler on 30.06.2023.
//

import SwiftUI
import PhotosUI

class HomeViewModel : ObservableObject {
    
    @Published var black : Color = Color("Black")
    @Published var orange : Color = Color("Orange")
    @Published var cardBG : Color = Color("cardBG")
    @Published var bG : Color = Color("BG")
    
    @Published var currentUser : GenderUser = GenderUser( name: "", age: "",birthDay: "",livecity:"", description: "", gender : "", orientation: [], interest : "", distance : "", wantLook : "",school: "", isVisibleGender: false, isVisibleOrientation: false ,photos: [], hobies: [], likes: [], dislike: [], superlike: [])
    
    @Published var isDefineUser = true
    @Published var defineCount = 1
    
    @Published var name: String = ""
    
    @Published var defineBirthDayD1 = ""
    @Published var defineBirthDayD2 = ""
    @Published var defineBirthDayM1 = ""
    @Published var defineBirthDayM2 = ""
    @Published var defineBirthDayY1 = ""
    @Published var defineBirthDayY2 = ""
    @Published var defineBirthDayY3 = ""
    @Published var defineBirthDayY4 = ""
    
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
    @Published var photoId = 0
    
    @Published var selectedPhoto : [UIImage?] = []
    @Published var showPicker: Bool = false
    @Published var foto1 : UIImage? = nil
    @Published var foto2 : UIImage? = nil
    @Published var foto3 : UIImage? = nil
    @Published var foto4 : UIImage? = nil
    @Published var foto5 : UIImage? = nil
    @Published var foto6 : UIImage? = nil
    
    @Published var rotation = 30.0
    @Published var users : [GenderUser] = []
    @Published var isConnected : Bool = true
    @Published var isLogin : Bool = true
    @Published var isFocused = false
    @Published var isProgress = false
    @Published var isProfile = false
    @Published var isSettings = false
    @Published var isStartSearched = false
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    let userData : FirestoreProtocol = UserData()
    let userConnection : AuthProtocol = UserConnection()
    let userStorage : StorageProtocol = UserStorage()
    
    init() {
        self.isConnected = !self.userConnection.isConnected()
        if !self.isConnected {
            self.getUsersData()
        }
        
        getUser()
    }
    
    func logoutUser() {
        DispatchQueue.main.async {
            self.userConnection.logout()
            self.isConnected = true
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
                            self.isProgress = false
                            
                        case .success(let auth):
                            print(auth)
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
                            self.isProgress = false
                        case .success(let auth):
                            print(auth)
                            self.addUpdateUser()
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
    
    func addUpdateUser() {
        getUsersData()
        if let id = self.userConnection.getCurrentUser()?.uid {
            self.currentUser.id = id
        }
        self.currentUser.name = name
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        
        let age = "\(year - Int(defineBirthDayY1 + defineBirthDayY2 + defineBirthDayY3 + defineBirthDayY4)!)"
        self.currentUser.age = age
        self.currentUser.birthDay = "\(defineBirthDayD1)\(defineBirthDayD2)/\(defineBirthDayM1)\(defineBirthDayM2)/\(defineBirthDayY1)\(defineBirthDayY2)\(defineBirthDayY3)\(defineBirthDayY4)"
        self.currentUser.gender = selectedGender
        self.currentUser.orientation = selectedOrientation
        self.currentUser.interest = selectedInterested
        self.currentUser.distance = "\(Int(definePosition.x))"
        self.currentUser.wantLook = selectedLook
        self.currentUser.school = selectedSchool
        self.currentUser.hobies = selectedHobiesList
        
        self.selectedPhoto.append(foto1)
        self.selectedPhoto.append(foto2)
        self.selectedPhoto.append(foto3)
        self.selectedPhoto.append(foto4)
        self.selectedPhoto.append(foto5)
        self.selectedPhoto.append(foto6)
        
        self.currentUser.isVisibleGender = isVisibleGender
        self.currentUser.isVisibleOrientation = isVisibleOrientation
        
        var num = 1
        for i in self.selectedPhoto {
            if let img = i {
                let data = img.jpegData(compressionQuality: 0.5)
                
                self.userStorage.UploadUserPhoto(id: self.currentUser.id, photonum: "\(num)", data: data)
                self.currentUser.photos.append("\(self.currentUser.id)/\(self.currentUser.id)\(num).jpg")
            }
            num += 1
        }
        
        self.userData.addUpdateUser(genderUser: self.currentUser) { result in
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
        for user in self.users {
            self.randomPhoto = []
            for photo in user.photos {
                self.userStorage.DownloadUserPhoto(url: photo) { data in
                    if let data = data {
                        let image = UIImage(data: data)
                        self.randomPhoto.append(image)
                    }
                }
            }
        }
    }
    
    
    func getUsersData() {
        self.isProgress = true
        userData.fetchData { result in
            switch result{
            case .failure(_):
                print("Hata!")
                self.isProgress = false
            case .success(let data):
                if let data = data {
                    self.users = data
                    
                    self.currentUser =  self.users.filter { user in
                        user.id == self.userConnection.getCurrentUser()?.uid
                    }.first ?? self.currentUser
                    
                    self.name = self.currentUser.name
                    
                    if self.currentUser.birthDay != "" {
                        let splitBirthDay = self.currentUser.birthDay.split(separator: "")
                        self.defineBirthDayD1 = String(splitBirthDay[0])
                        self.defineBirthDayD2 = String(splitBirthDay[1])
                        self.defineBirthDayM1 = String(splitBirthDay[3])
                        self.defineBirthDayM2 = String(splitBirthDay[4])
                        self.defineBirthDayY1 = String(splitBirthDay[6])
                        self.defineBirthDayY2 = String(splitBirthDay[7])
                        self.defineBirthDayY3 = String(splitBirthDay[8])
                        self.defineBirthDayY4 = String(splitBirthDay[9])
                    }
                    
                    
                    self.selectedGender = self.currentUser.gender
                    
                    if (self.currentUser.orientation != []) {
                        self.selectedOrientation = []
                        for i in self.currentUser.orientation {
                            if let i = i {
                                self.selectedOrientation.append(i)
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
                        self.selectedHobiesList = []
                        for i in self.currentUser.hobies {
                            if let i = i {
                                self.selectedHobiesList.append(i)
                            }
                        }
                    }
                    
                    let visibleGender = self.currentUser.isVisibleGender
                    self.isVisibleGender = visibleGender
                    
                    let visibleOrientation = self.currentUser.isVisibleOrientation
                    self.isVisibleOrientation = visibleOrientation
                    
                    DispatchQueue.main.async {
                        if (self.currentUser.photos != []) {
                            self.selectedPhoto = []
                            for i in self.currentUser.photos {
                                self.userStorage.DownloadUserPhoto(url: i) { data in
                                    if let data = data {
                                        let image = UIImage(data: data)
                                        self.selectedPhoto.append(image)
                                    }
                                }
                            }
                        }
                    }
                    
                    if self.currentUser.name == "" {
                        self.defineCount = 1
                    } else if self.currentUser.age == "" {
                        self.defineCount = 2
                    } else if self.currentUser.gender == "" {
                        self.defineCount = 3
                    } else if self.currentUser.interest == "" {
                        self.defineCount = 5
                    } else if self.currentUser.distance == "" {
                        self.defineCount = 6
                    } else if self.currentUser.wantLook == "" {
                        self.defineCount = 7
                    } else if self.currentUser.photos.count < 2 {
                        self.defineCount = 10
                    } else {
                        self.defineCount = 11
                        self.isDefineUser = false
                    }
                    
                    self.isProgress = false
                }
            }
        }
    }
}
