//
//  UserConnection.swift
//  Gender
//
//  Created by İbrahim Güler on 30.06.2023.
//

import Firebase

protocol AuthProtocol {
    var getUid : String? { get }
    
    func logout()
    func loginUser(email: String, password: String, completion : @escaping (Result<AuthDataResult, AuthError>) -> ())
    func registerUser(email: String, password: String, completion : @escaping (Result<AuthDataResult, AuthError>) -> ())
}

struct UserConnection : AuthProtocol {
    
    private let auth : Auth = Auth.auth()
    
    var getUid : String? {
        guard let currentUser = auth.currentUser else { return nil }
        return currentUser.uid
    }
    
    func logout() {
        do {
            try auth.signOut()
        } catch {
            print("Logout eror : \(error.localizedDescription)")
        }
     
    }
    
    
    
    func loginUser(email: String, password: String, completion : @escaping (Result<AuthDataResult, AuthError>) -> ()) {
        auth.signIn(withEmail: email, password: password) { result, error in
            
            guard error == nil  else {
                completion(.failure(.haveError))
                return
            }
            
            guard let result = result else {
                completion(.failure(.dontHandleData))
                return
            }
            
            completion(.success(result))
        }
    }
    
    func registerUser(email: String, password: String, completion : @escaping (Result<AuthDataResult, AuthError>) -> ()) {
        auth.createUser(withEmail: email, password: password) { result, error in
            
            guard error == nil else {
                completion(.failure(.haveError))
                return
            }
            
            guard let result = result  else {
                completion(.failure(.dontHandleData))
                return
            }
            
            completion(.success(result))
        }
    }
    
}

enum AuthError : Error {
    case haveError
    case dontHandleData
}
