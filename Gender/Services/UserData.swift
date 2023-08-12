//
//  FetchUserData.swift
//  Gender
//
//  Created by İbrahim Güler on 30.06.2023.
//

import Firebase

protocol FirestoreProtocol {    
    func fetchData(completion : @escaping (Result<[GenderUser]?, FirestoreError>) -> ())
    func addUpdateUser(genderUser: GenderUser, completion : @escaping (Result<Bool, FirestoreError>) -> ())
    func deleteUser(genderUser: GenderUser, completion : @escaping (Result<Bool, FirestoreError>) -> ())
}

struct UserData : FirestoreProtocol {
    
    let firestore = Firestore.firestore()
    
    func fetchData(completion : @escaping (Result<[GenderUser]?, FirestoreError>) -> ()) {
        var data : [GenderUser] = [GenderUser]()
        firestore.collection("Users").addSnapshotListener { result, error in
            if let error = error { print(error.localizedDescription) }
            guard let documents = result?.documents else {
                print("No documents")
                return
            }
            data = documents.compactMap({ query in
                var user : GenderUser = GenderUser(name: "", age: "",birthDay:"",livecity:"", description: "", gender : "", orientation: [], interest : "", distance : "", wantLook : "",school: "", isVisibleGender: false, isVisibleOrientation: false ,photos: [], hobies: [], likes: [], dislike: [], superlike: [])
                
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
                        } else if i.key == "orientation" {
                            user.orientation = list
                        }
                    } else {
                        if i.key == "id" {
                            user.id = "\(i.value)"
                        } else if i.key == "birthDay" {
                            user.birthDay = "\(i.value)"
                        }  else if i.key == "name" {
                            user.name = "\(i.value)"
                        } else if i.key == "age" {
                            user.age = "\(i.value)"
                        } else if i.key == "livecity" {
                            user.livecity = "\(i.value)"
                        } else if i.key == "description" {
                            user.description = "\(i.value)"
                        } else if i.key == "gender" {
                            user.gender = "\(i.value)"
                        } else if i.key == "interest" {
                            user.interest = "\(i.value)"
                        } else if i.key == "isVisibleGender" {
                            if let bool = i.value as? Bool {
                                user.isVisibleGender = bool
                            }
                        } else if i.key == "isVisibleOrientation" {
                            if let bool = i.value as? Bool {
                                user.isVisibleOrientation = bool
                            }
                        } else if i.key == "distance" {
                            user.distance = "\(i.value)"
                        } else if i.key == "wantLook" {
                            user.wantLook = "\(i.value)"
                        } else if i.key == "school" {
                            user.school = "\(i.value)"
                        }
                    }
                }

                return user
            })
            
            completion(.success(data))
            
        }
    }
    
    func addUpdateUser(genderUser: GenderUser, completion : @escaping (Result<Bool, FirestoreError>) -> ()) {
        
        let data = getData(genderUser: genderUser)
        
        firestore.collection("Users").document(genderUser.id).setData(data) { error in
            if let error = error { print(error.localizedDescription) }
            completion(.success(true))
        }
    }
    
    func deleteUser(genderUser: GenderUser, completion : @escaping (Result<Bool, FirestoreError>) -> ()) {
        firestore.collection("Users").document(genderUser.id).delete() { error in
            if let error = error { print(error.localizedDescription) }
            completion(.success(true))
        }
    }
    
    private func getData(genderUser: GenderUser) -> [String: Any] {
        var data : [String: Any] = [:]
        genderUser.id != "" ? data["id"] = genderUser.id : nil
        genderUser.name != "" ? data["name"] = genderUser.name : nil
        genderUser.age != "" ? data["age"] = genderUser.age : nil
        genderUser.birthDay != "" ? data["birthDay"] = genderUser.birthDay : nil
        genderUser.livecity != "" ? data["livecity"] = genderUser.livecity : nil
        genderUser.description != "" ? data["description"] = genderUser.description : nil
        genderUser.gender != "" ? data["gender"] = genderUser.gender : nil
        genderUser.orientation != [] ? data["orientation"] = genderUser.orientation : nil
        genderUser.interest != "" ? data["interest"] = genderUser.interest : nil
        genderUser.distance != "" ? data["distance"] = genderUser.distance : nil
        genderUser.wantLook != "" ? data["wantLook"] = genderUser.wantLook : nil
        genderUser.school != "" ? data["school"] = genderUser.school : nil
        
        data["isVisibleGender"] = genderUser.isVisibleGender
        data["isVisibleOrientation"] = genderUser.isVisibleOrientation
        
        genderUser.photos != [] ? data["photos"] = genderUser.photos : nil
        genderUser.hobies != [] ? data["hobies"] = genderUser.hobies : nil
        genderUser.likes != [] ? data["likes"] = genderUser.likes : nil
        genderUser.dislike != [] ? data["dislike"] = genderUser.dislike : nil
        genderUser.superlike != [] ? data["superlike"] = genderUser.superlike : nil
        
        return data
    }
    
}


enum FirestoreError : Error {
    case dontCatchData
    case dontHandleData
}
