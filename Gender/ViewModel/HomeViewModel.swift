//
//  HomeViewModel.swift
//  Gender
//
//  Created by İbrahim Güler on 30.06.2023.
//

import Foundation

class HomeViewModel : ObservableObject{
    
    @Published var currentUser : User = User(username: "", photos: [], name: "", surname: "", age: "", description: "", hobies: [], likes: [], dislike: [], superlike: [])
    @Published var users : [User] = []
    @Published var isConnected : Bool = false
    @Published var isLogin : Bool = true
    @Published var isFocused = false
    @Published var isProgress = false
    @Published var isProfile = false
    @Published var isSettings = false
    @Published var isStartSearched = false

    
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
                if self.name != "" {
                    if self.surname != "" {
                        if self.age != "" {
                            self.isProgress = true
                            let username = self.email.split(separator: "@")[0]
                            let user : User = User(username: String(username), photos: [], name: self.name, surname: self.surname, age: self.age, description: "", hobies: [], likes: [], dislike: [], superlike: [])
                            DispatchQueue.main.async {
                                self.userConnection.registerUser(email: self.email, password: self.password) { result in
                                    switch result {
                                    case .failure(_):
                                        print("Hata !")
                                        self.isProgress = false
                                    case .success(let auth):
                                        print(auth)
                                        self.userData.addUser(user: user) { added in
                                            switch added {
                                            case .failure(_):
                                                print("Hata !")
                                                self.isProgress = false
                                            case .success(let add):
                                                print(add)
                                                self.isConnected = true
                                                self.email = ""
                                                self.password = ""
                                                self.name = ""
                                                self.surname = ""
                                                self.age = ""
                                                self.isProgress = false
                                            }
                                        }
                                    }
                                }
                            }
                        }
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
                        user.username == self.userConnection.getUsername()
                    }.first!
                    self.isProgress = false
                }
            }
        }
    }
}
