//
//  GenderUser.swift
//  Gender
//
//  Created by İbrahim Güler on 30.06.2023.
//

import SwiftUI

struct GenderUser : Codable, Identifiable {
    
    var id : String = UUID().uuidString
    var name : String
    var age : String
    var birthDay : String
    var livecity : String
    var description : String?
    var gender : String
    var orientation : [String?]
    var interest : String?
    var distance : String?
    var wantLook : String?
    var school : String?
    var isVisibleGender : Bool
    var isVisibleOrientation : Bool
    var photos : [String]
    var hobies : [String?]
    var likes : [String?]
    var dislike : [String?]
    var superlike : [String?]
    
}
