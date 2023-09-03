//
//  DefineUserViewModel.swift
//  Gender
//
//  Created by İbrahim Güler on 22.08.2023.
//

import SwiftUI

final class DefineUserViewModel : ObservableObject {
    
    var userData : FirestoreProtocol
    var userStorage : StorageProtocol
    
    var orientationTags: [String] = ["Heterosexual", "Heterosexual1", "Heterosexual2", "Heterosexual3", "Heterosexual4", "Heterosexual5", "Heterosexual6", "Heterosexual7", "Heterosexual8", "Heterosexual9", "Heterosexual10", "Heterosexual11", "Heterosexual12"]
    var hobiesTags: [String] = ["Lorem", "Ipsum", "dolor", "consectetur", "adipiscing", "elit", "Nam", "semper", "sit", "amet", "ut", "eleifend", "Cras"]
    
    @Published var currentUser : GenderUser = GenderUser()
    @Published var defineCount : Int = 1
    
    @Published var defineBirthDay : [String] = ["","","/","","","/","","","",""]
    @Published var selectedPhoto : [Int: UIImage] = [:]
    @Published var showPicker: Bool = false
    
    @Published var position : CGPoint = CGPoint()
    @Published var height : CGFloat = .zero
    
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
    
    @Published var defineProgress: Bool
    
    private var definationUserInfo : GenderUser {
        var num = 1
        for i in self.selectedPhoto {
            let img = i.value
                let data = img.jpegData(compressionQuality: 1)
                let url = "\(self.currentUser.id)/\(self.currentUser.id)\(num).jpg"
                
                self.userStorage.UploadUserPhoto(url: url, data: data)
                self.photos.append(url)
            
            num += 1
        }
        
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
        
        user.defineUser = true
    
        user.orientation = self.orientation
        user.hobies = self.hobies
        
        user.photos = self.photos
        user.likes = self.likes
        user.dislike = self.dislike
        user.superlike = self.superlike
        
        return user
    }
    
    init(userData : FirestoreProtocol, userStorage : StorageProtocol, defineProgress: Bool) {
        self.userData = userData
        self.userStorage = userStorage
        self.defineProgress = defineProgress
    }
    
    func AddUser() {
        self.defineProgress = true
        self.userData.AddUser(genderUser: self.definationUserInfo) { result in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: .init(block: {
                switch result {
                case .failure(let error):
                    self.defineProgress = false
                    print(error)
                case.success(let succ):
                    self.defineProgress = false
                    print(succ)
                }
            }))
        }
        
    }
    
}

/*
 protocol DefineUserViewModelProtocol {
     var userData : FirestoreProtocol {get}
     var userStorage : StorageProtocol {get}
     
     var orientationTags : [String]  {get}
     var hobiesTags : [String]  {get}
     
     var currentUser : GenderUser  {get}
     var defineCount : Int  {get}
     
     var defineBirthDay : [String]  {get}
     var selectedPhoto : [Int: UIImage]  {get}
     var showPicker: Bool  {get}
     
     var position : CGPoint  {get}
     var height : CGFloat {get}
     
     var name : String {get}

     var gender : String {get}
     var interest : String {get}
     var distance : String {get}
     var wantLook : String {get}
     var school : String {get}
     
     var isVisibleGender : Bool {get}
     var isVisibleOrientation : Bool {get}
     
     var orientation : [String] {get}
     var photos : [String] {get}
     var hobies : [String] {get}
     var likes : [String] {get}
     var dislike : [String] {get}
     var superlike : [String] {get}
     
     var defineProgress: Bool {get}
     
     func AddUser()
 }
 */
