//
//  FetchUserData.swift
//  Gender
//
//  Created by İbrahim Güler on 30.06.2023.
//

import Firebase

class UserData {
    
    let auth : Auth = Auth.auth()
    let firestore : Firestore = Firestore.firestore()
    
    func loginUser(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error?.localizedDescription ?? "Hata oluştu !")
            }
        }
    }
    
    func registerUser(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error?.localizedDescription ?? "Hata oluştu !")
            }
        }
    }
    
    func addUser(user: User) {
        
        var data : [String: Any] = [:]
        user.id == "" ? data["id"] = user.id : nil
        user.username == "" ? data["username"] = user.username : nil
        user.photos == [] ? data["photos"] = user.photos : nil
        user.name == "" ? data["name"] = user.name : nil
        user.surname == "" ? data["surname"] = user.surname : nil
        user.age == "" ? data["age"] = user.age : nil
        user.description == "" ? data["description"] = user.description : nil
        user.hobies == [] ? data["hobies"] = user.hobies : nil
        user.likes == [] ? data["likes"] = user.likes : nil
        user.dislike == [] ? data["dislike"] = user.dislike : nil
        user.superlike == [] ? data["superlike"] = user.superlike : nil
        
        firestore.collection("Users").addDocument(data: data) { error in
            if error != nil {
                print(error?.localizedDescription ?? "Hata oluştu !")
            }
        }
    }
    
    func updateUser(user: User) {
        var data : [String: Any] = [:]
        user.id == "" ? data["id"] = user.id : nil
        user.username == "" ? data["username"] = user.username : nil
        user.photos == [] ? data["photos"] = user.photos : nil
        user.name == "" ? data["name"] = user.name : nil
        user.surname == "" ? data["surname"] = user.surname : nil
        user.age == "" ? data["age"] = user.age : nil
        user.description == "" ? data["description"] = user.description : nil
        user.hobies == [] ? data["hobies"] = user.hobies : nil
        user.likes == [] ? data["likes"] = user.likes : nil
        user.dislike == [] ? data["dislike"] = user.dislike : nil
        user.superlike == [] ? data["superlike"] = user.superlike : nil
        
        firestore.collection("Users").document(user.id).setData(data) { error in
            if error != nil {
                print(error?.localizedDescription ?? "Hata oluştu !")
            }
        }
    }
    
    func deleteUser(user: User) {
        firestore.collection("Users").document(user.id).delete() { error in
            if error != nil {
                print(error?.localizedDescription ?? "Hata oluştu !")
            }
        }
    }
    
}
