//
//  User.swift
//  Gender
//
//  Created by İbrahim Güler on 30.06.2023.
//

import SwiftUI

struct User : Codable, Identifiable {
    
    var id : String = UUID().uuidString
    var username : String
    var photos : [String]
    var name : String
    var surname : String
    var age : String
    var description : String
    var hobies : [String]
    var likes : [String]
    var dislike : [String]
    var superlike : [String]
    
}
