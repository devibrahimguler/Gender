//
//  HomeViewModel.swift
//  Gender
//
//  Created by İbrahim Güler on 30.06.2023.
//

import Foundation

class HomeViewModel : ObservableObject{
    
    @Published var currentUser : GenderUser = GenderUser(username: "", name: "", surname: "", age: "",livecity:"", description: "", gender : "", interest : "" ,photos: [], hobies: [], likes: [], dislike: [], superlike: [])
    @Published var users : [GenderUser] = []
    @Published var isConnected : Bool = false
    @Published var isLogin : Bool = true
    @Published var isFocused = false
    @Published var isProgress = false
    @Published var isProfile = false
    @Published var isSettings = false
    @Published var isStartSearched = false
    
    @Published var defineCount = 1
    @Published var defineBirthDayD1 = ""
    @Published var defineBirthDayD2 = ""
    @Published var defineBirthDayM1 = ""
    @Published var defineBirthDayM2 = ""
    @Published var defineBirthDayY1 = ""
    @Published var defineBirthDayY2 = ""
    @Published var defineBirthDayY3 = ""
    @Published var defineBirthDayY4 = ""
    
    @Published var definePosition : CGPoint = CGPoint()
    
    @Published var rotation = 30.0
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var age: String = ""
    
    let userData : FirestoreProtocol = UserData()
    let userConnection : AuthProtocol = UserConnection()
    
    init() {
        self.isConnected = self.userConnection.isConnected()
        if self.isConnected {
            self.getUsersData()
        }
    }
    
    func logoutUser() {
        DispatchQueue.main.async {
            self.userConnection.logout()
            self.isConnected = false
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
    
    func definateUser() {
        if self.currentUser.name != "" || self.currentUser.surname != ""  {
            if self.currentUser.livecity != "" || self.currentUser.description != "" || self.currentUser.gender != "" || self.currentUser.interest != "" {
                if self.currentUser.age != "" {
                    if self.currentUser.photos != [] {
                        
                        
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
                        user.username == self.userConnection.getCurrentUser()?.email?.split(separator: "@")[0] ?? ""
                    }.first!
                    self.isProgress = false
                }
            }
        }
    }
}
