//
//  GenderUser.swift
//  Gender
//
//  Created by İbrahim Güler on 30.06.2023.
//

import SwiftUI

struct GenderUser : Codable, Identifiable {
    
    var id : String = UUID().uuidString
    var username : String
    var name : String
    var surname : String
    var age : String
    var livecity : String
    var description : String
    var gender : String
    var interest : String
    var photos : [String]
    var hobies : [String]
    var likes : [String]
    var dislike : [String]
    var superlike : [String]
    
}
