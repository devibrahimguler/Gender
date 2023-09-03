//
//  EntryViewModel.swift
//  Gender
//
//  Created by İbrahim Güler on 1.09.2023.
//

import SwiftUI

final class EntryViewModel: ObservableObject {
    
    var userConnection : AuthProtocol
    
    @Binding var entryProgress: Bool
    @Binding var isConnected : Bool
    
    @Published var isFocused : Bool = false
    @Published var isLogin : Bool = true
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    init(userConnection : AuthProtocol, entryProgress: Binding<Bool>, isConnected : Binding<Bool>) {
        self.userConnection = userConnection
        self._entryProgress = entryProgress
        self._isConnected = isConnected
    }
    
    func loginUser() {
        
        if self.email == "" { return }
        if self.password == "" { return }
        
        self.entryProgress = true
        DispatchQueue.main.async {
            
            self.userConnection.loginUser(email: self.email, password: self.password) { result in
                switch result {
                    
                case .failure(_):
                    
                    print("Hata !")
                    self.userConnection.logout()
                    self.entryProgress = false
                    
                case .success(_):
                    self.isConnected = true
                    
                    self.email = ""
                    self.password = ""
                    
                    self.entryProgress = false
      
                }
            }
        }
    }
    
    func registerUser() {
        
        if self.email == "" { return }
        if self.password == "" { return }
        
        DispatchQueue.main.async {
             
            self.userConnection.registerUser(email: self.email, password: self.password) { result in
                switch result {
                    
                case .failure(_):
                    
                    print("Hata !")
                    
                    self.userConnection.logout()
                    
                case .success(_):
                    self.email = ""
                    self.password = ""
                    
                }
            }
            
        }
        
    }
}

/*
 protocol EntryViewModelProtocol {
     var userConnection : AuthProtocol {get}
     
     var entryProgress : Bool  {get}
     var isConnected : Bool  {get}
     
     var isFocused : Bool  {get}
     var isLogin : Bool  {get}
     
     var email : String  {get}
     var password : String  {get}
     
     func loginUser()
     func registerUser()
 }
 */

