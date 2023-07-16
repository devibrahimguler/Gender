//
//  UserConnection.swift
//  Gender
//
//  Created by İbrahim Güler on 30.06.2023.
//

import Firebase

protocol AuthProtocol {
    func getCurrentUser() -> User?
    func logout()
    func isConnected() -> Bool
    func loginUser(email: String, password: String, completion : @escaping (Result<AuthDataResult, AuthError>) -> ())
    func registerUser(email: String, password: String, completion : @escaping (Result<AuthDataResult, AuthError>) -> ())
}

struct UserConnection : AuthProtocol {
    
    let auth : Auth = Auth.auth()
    
    func getCurrentUser() -> User? {
        guard let currentUser = auth.currentUser else { return nil}
        return currentUser
    }
    
    func logout() {
        do {
            try auth.signOut()
        } catch {
            print("Hata !")
        }
     
    }
    
    func isConnected() -> Bool {
        if let auth = auth.currentUser {
            print(auth.description)
            return true
        }
        return false
    }
    
    func loginUser(email: String, password: String, completion : @escaping (Result<AuthDataResult, AuthError>) -> ()) {
        auth.signIn(withEmail: email, password: password) { result, error in
            if let error = error { print(error.localizedDescription) }
            if let result = result { completion(.success(result)) }
        }
    }
    
    func registerUser(email: String, password: String, completion : @escaping (Result<AuthDataResult, AuthError>) -> ()) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let error = error { print(error.localizedDescription) }
            if let result = result { completion(.success(result)) }
        }
    }
    
}

enum AuthError : Error {
    case dontCatchData
    case dontHandleData
}
