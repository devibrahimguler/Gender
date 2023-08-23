//
//  GenderUser.swift
//  Gender
//
//  Created by İbrahim Güler on 30.06.2023.
//

import SwiftUI

struct GenderUser : Codable, Identifiable {
    
    var id : String = UUID().uuidString
    
    var name : String?
    var age : String?
    var birthDay : String?
    var livecity : String?
    var description : String?
    var gender : String?
    var interest : String?
    var distance : String?
    var wantLook : String?
    var school : String?
    
    var isVisibleGender : Bool?
    var isVisibleOrientation : Bool?
    var defineUser : Bool?
    
    var orientation : [String?]?
    var photos : [String?]?
    var hobies : [String?]?
    var likes : [String?]?
    var dislike : [String?]?
    var superlike : [String?]?
    
    enum CodingKey: String {
        case id = "id"
        
        case name = "name"
        case age = "age"
        case birthDay = "birthDay"
        case livecity = "livecity"
        case description = "description"
        case gender = "gender"
        case interest = "interest"
        case distance = "distance"
        case wantLook = "wantLook"
        case school = "school"
        
        case isVisibleGender = "isVisibleGender"
        case isVisibleOrientation = "isVisibleOrientation"
        case defineUser = "defineUser"
        
        case orientation = "orientation"
        case photos = "photos"
        case likes = "likes"
        case dislike = "dislike"
        case superlike = "superlike"
    }
    
}
