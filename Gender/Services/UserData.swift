//
//  FetchUserData.swift
//  Gender
//
//  Created by İbrahim Güler on 30.06.2023.
//

import Firebase

protocol FirestoreProtocol {    
    func fetchData(completion : @escaping (Result<[User]?, FirestoreError>) -> ())
    func addUser(user: User, completion : @escaping (Result<Bool, FirestoreError>) -> ())
    func updateUser(user: User, completion : @escaping (Result<Bool, FirestoreError>) -> ())
    func deleteUser(user: User, completion : @escaping (Result<Bool, FirestoreError>) -> ())
}

struct UserData : FirestoreProtocol {
    
    let firestore = Firestore.firestore()
    
    func fetchData(completion : @escaping (Result<[User]?, FirestoreError>) -> ()) {
        var data : [User] = [User]()
        firestore.collection("Users").addSnapshotListener { result, error in
            if let error = error { print(error.localizedDescription) }
            guard let documents = result?.documents else {
                print("No documents")
                return
            }
            data = documents.compactMap({ query in
                var user : User = User(username: "", photos: [], name: "", surname: "", age: "", description: "", hobies: [], likes: [], dislike: [], superlike: [])
                
                for i in query.data() {
                    if let list = i.value as? [String] {
                        if i.key == "photos" {
                            user.photos = list
                        } else if i.key == "hobies" {
                            user.hobies = list
                        } else if i.key == "likes" {
                            user.likes = list
                        } else if i.key == "dislike" {
                            user.dislike = list
                        } else if i.key == "superlike" {
                            user.superlike = list
                        }
                    } else {
                        if i.key == "id" {
                            user.id = "\(i.value)"
                        } else if i.key == "username" {
                            user.username = "\(i.value)"
                        }  else if i.key == "name" {
                            user.name = "\(i.value)"
                        } else if i.key == "surname" {
                            user.surname = "\(i.value)"
                        } else if i.key == "age" {
                            user.age = "\(i.value)"
                        } else if i.key == "description" {
                            user.description = "\(i.value)"
                        }
                    }
                }

                return user
            })
            
            completion(.success(data))
            
        }
    }
    
    func addUser(user: User, completion : @escaping (Result<Bool, FirestoreError>) -> ()) {
        
        let data = getData(user: user)
        
        firestore.collection("Users").addDocument(data: data) { error in
            if let error = error { print(error.localizedDescription) }
            completion(.success(true))
        }
    }
    
    func updateUser(user: User, completion : @escaping (Result<Bool, FirestoreError>) -> ()) {
        
        let data = getData(user: user)
        
        firestore.collection("Users").document(user.id).setData(data) { error in
            if let error = error { print(error.localizedDescription) }
            completion(.success(true))
        }
    }
    
    func deleteUser(user: User, completion : @escaping (Result<Bool, FirestoreError>) -> ()) {
        firestore.collection("Users").document(user.id).delete() { error in
            if let error = error { print(error.localizedDescription) }
            completion(.success(true))
        }
    }
    
    private func getData(user: User) -> [String: Any] {
        var data : [String: Any] = [:]
        user.id != "" ? data["id"] = user.id : nil
        user.username != "" ? data["username"] = user.username : nil
        user.photos != [] ? data["photos"] = user.photos : nil
        user.name != "" ? data["name"] = user.name : nil
        user.surname != "" ? data["surname"] = user.surname : nil
        user.age != "" ? data["age"] = user.age : nil
        user.description != "" ? data["description"] = user.description : nil
        user.hobies != [] ? data["hobies"] = user.hobies : nil
        user.likes != [] ? data["likes"] = user.likes : nil
        user.dislike != [] ? data["dislike"] = user.dislike : nil
        user.superlike != [] ? data["superlike"] = user.superlike : nil
        
        return data
    }
    
}


enum FirestoreError : Error {
    case dontCatchData
    case dontHandleData
}
