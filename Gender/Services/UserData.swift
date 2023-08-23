//
//  FetchUserData.swift
//  Gender
//
//  Created by İbrahim Güler on 30.06.2023.
//

import Firebase

protocol FirestoreProtocol {    
    func FetchData(completion : @escaping (Result<[GenderUser]?, FirestoreError>) -> ())
    func AddUser(genderUser: GenderUser, completion : @escaping (Result<Bool, FirestoreError>) -> ())
    func DeleteUser(genderUser: GenderUser, completion : @escaping (Result<Bool, FirestoreError>) -> ())
}

struct UserData : FirestoreProtocol {
    
    private let firestore = Firestore.firestore()
    
    func FetchData(completion : @escaping (Result<[GenderUser]?, FirestoreError>) -> ()) {
        var data : [GenderUser] = [GenderUser]()
        firestore.collection("Users").addSnapshotListener { result, error in
            
            guard error == nil  else {
                completion(.failure(.haveError))
                return
            }
            
            guard let documents = result?.documents else {
                completion(.failure(.dontCatchData))
                return
            }
            
            for document in documents {
                if let user = ConvertGetData(document: document) {
                    data.append(user)
                }
            }
            
            if data.isEmpty {
                completion(.failure(.dontConvertData))
            }
            
            completion(.success(data))
            
        }
    }
    
    func AddUser(genderUser: GenderUser, completion : @escaping (Result<Bool, FirestoreError>) -> ()) {

        let data : [String: Any]  = ConvertSentData(genderUser: genderUser)
        
        firestore.collection("Users").document(genderUser.id).setData(data) { error in
            guard error == nil else {
                completion(.failure(.haveError))
                return
            }
            completion(.success(true))
        }
    }
    
    func DeleteUser(genderUser: GenderUser, completion : @escaping (Result<Bool, FirestoreError>) -> ()) {
        firestore.collection("Users").document(genderUser.id).delete() { error in
            guard error == nil else {
                completion(.failure(.haveError))
                return
            }
            completion(.success(true))
        }
    }
    
    private func ConvertSentData (genderUser: GenderUser) -> [String: Any] {
        var dictionary: [String: Any] {
              let data = (try? JSONEncoder().encode(genderUser)) ?? Data()
              return (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]) ?? [:]
          }
        
        return dictionary
    }
    
    private func ConvertGetData (document: QueryDocumentSnapshot) -> GenderUser? {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: document.data(), options: .prettyPrinted) else { return nil }
        guard let converted = try? JSONDecoder().decode(GenderUser.self, from: jsonData) else { return nil }
        
        return converted
    }
    
}


enum FirestoreError : Error {
    case haveError
    case dontCatchData
    case dontConvertData
}
