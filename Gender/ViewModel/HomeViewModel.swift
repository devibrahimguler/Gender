//
//  HomeViewModel.swift
//  Gender
//
//  Created by İbrahim Güler on 30.06.2023.
//

import SwiftUI
import PhotosUI

class HomeViewModel : ObservableObject{
    
    @Published var currentUser : GenderUser?
    
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
                            self.addingUser()
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
    
    func addingUser() {
        self.currentUser = GenderUser(username: "", name: "", age: "",livecity:"", description: "", gender : "", orientation: [], interest : "", distance : "", wantLook : "",school: "", isVisibleGender: false ,photos: [], hobies: [], likes: [], dislike: [], superlike: [])
        
        if let user = self.currentUser {
            self.userData.addUser(genderUser: user) { result in
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
                    }.first
                    /*
                     
                 
                    if let user = self.currentUser {
                        if user.name == "" {
                            self.defineCount = 1
                        } else if user.age == "" {
                            self.defineCount = 2
                        } else if user.gender == "" {
                            self.defineCount = 3
                        } else if user.interest == "" {
                            self.defineCount = 5
                        } else if user.distance == "" {
                            self.defineCount = 6
                        } else if user.wantLook == "" {
                            self.defineCount = 7
                        } else if user.photos.count < 2 {
                            self.defineCount = 10
                        } else {
                            self.isDefineUser = true
                        }
                    }
                     */
                    self.isProgress = false
                }
            }
        }
    }
}
