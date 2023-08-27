//
//  DefineUserViewModel.swift
//  Gender
//
//  Created by İbrahim Güler on 22.08.2023.
//

import SwiftUI

final class DefineUserViewModel : ObservableObject {
    
    private let userData : FirestoreProtocol = UserData()
    private let userConnection : AuthProtocol = UserConnection()
    
    @Published var orientationTags: [String] = ["Heterosexual", "Heterosexual1", "Heterosexual2", "Heterosexual3", "Heterosexual4", "Heterosexual5", "Heterosexual6", "Heterosexual7", "Heterosexual8", "Heterosexual9", "Heterosexual10", "Heterosexual11", "Heterosexual12"]
    @Published var hobiesTags: [String] = ["Lorem", "Ipsum", "dolor", "consectetur", "adipiscing", "elit", "Nam", "semper", "sit", "amet", "ut", "eleifend", "Cras"]
    
    @Published var currentUser : GenderUser = GenderUser()
    @Published var defineCount : Int = 1
    
    @Published var defineBirthDay : [String] = ["","","/","","","/","","","",""]
    @Published var selectedPhoto : [Int: UIImage] = [:]
    @Published var showPicker: Bool = false
    
    @Published var position : CGPoint = CGPoint()
    @Published var height = CGFloat.zero
    
    @Published var name : String = ""

    @Published var gender : String = ""
    @Published var interest : String = ""
    @Published var distance : String = ""
    @Published var wantLook : String = ""
    @Published var school : String = ""
    
    @Published var isVisibleGender : Bool = false
    @Published var isVisibleOrientation : Bool = false
    
    @Published var orientation : [String] = []
    @Published var photos : [String] =  []
    @Published var hobies : [String] =  []
    @Published var likes : [String] =  []
    @Published var dislike : [String] =  []
    @Published var superlike : [String] = []
    
    private var definationUserInfo : GenderUser {
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        
        var birthDayStr = ""
        for birth in defineBirthDay {
        birthDayStr += birth
        }
        
        var user : GenderUser = GenderUser()

        user.id = self.currentUser.id
        user.name = self.name
        
        if let birthYear = Int(defineBirthDay[6] + defineBirthDay[7] + defineBirthDay[8] + defineBirthDay[9]) {
        let age = "\(year - birthYear)"
            user.age = age
        }

        user.birthDay = birthDayStr
        user.gender = self.gender
        user.interest = self.interest
        user.distance = self.distance
        user.wantLook = self.wantLook
        user.school = self.school
        
        user.isVisibleGender = self.isVisibleGender
        user.isVisibleOrientation = self.isVisibleOrientation
        
        if self.defineCount >= 11 {
            user.defineUser = true
        }
    
        user.orientation = self.orientation
        user.hobies = self.hobies
        
        user.photos = self.photos
        user.likes = self.likes
        user.dislike = self.dislike
        user.superlike = self.superlike
        
        return user
    }
    
    init() {
        if let id = self.userConnection.getUid {
            self.currentUser.id = id
        }
    }
    
    private func defineStringControl(list : [Int : String]) -> Int? {
        for i in 0...(list.count - 1) {
            if list[i] == "" {
                return i
            }
        }
        return nil
    }
    
    func AddUser() {
        self.userData.AddUser(genderUser: self.definationUserInfo) { result in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: .init(block: {
                switch result {
                case .failure(let error):
                    print(error)
                case.success(let succ):
                    print(succ)
                    
                }
            }))
        }
        
    }
    
}
