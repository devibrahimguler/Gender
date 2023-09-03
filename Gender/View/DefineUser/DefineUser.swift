//
//  DefineUser.swift
//  Gender
//
//  Created by İbrahim Güler on 4.07.2023.
//

import SwiftUI

struct DefineUser: View {
    
    @ObservedObject var defineUserViewModel : DefineUserViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(id: String, userData : FirestoreProtocol, userStorage : StorageProtocol, defineProgress: Bool) {
        self.defineUserViewModel = DefineUserViewModel(userData: userData, userStorage: userStorage, defineProgress: defineProgress)
        self.defineUserViewModel.currentUser.id = id
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                ForEach(0...defineUserViewModel.defineCount, id: \.self) { i in
                    
                    Rectangle()
                        .fill(.red)
                        .frame(width: getRect().width / 10, height: 10)
                        .offset(x: defineUserViewModel.defineCount == i ? -200 : 0)
                        .animation(.linear, value: defineUserViewModel.defineCount)
                    
               
                }
                
            }
            .frame(width: getRect().width, alignment: .leading)
            
            
            switch(defineUserViewModel.defineCount) {
            case 1:
                DefineNames(name: $defineUserViewModel.name, defineCount: $defineUserViewModel.defineCount)
            case 2:
                DefineBirthDay(list: $defineUserViewModel.defineBirthDay, count: $defineUserViewModel.defineCount)
            case 3:
                DefineGender(selected: $defineUserViewModel.gender, defineCount: $defineUserViewModel.defineCount, isVisible: $defineUserViewModel.isVisibleGender)
            case 4:
                DefineOrientation(orientationTags: defineUserViewModel.orientationTags, selected: $defineUserViewModel.orientation, defineCount: $defineUserViewModel.defineCount, isVisible: $defineUserViewModel.isVisibleOrientation)
            case 5:
                DefineInterested(selected: $defineUserViewModel.interest, defineCount: $defineUserViewModel.defineCount)
            case 6:
                DefineDistance(position: $defineUserViewModel.position, defineCount: $defineUserViewModel.defineCount)
            case 7:
                DefineLook(selected: $defineUserViewModel.wantLook, defineCount: $defineUserViewModel.defineCount)
            case 8:
                DefineSchool(selected: $defineUserViewModel.school, defineCount: $defineUserViewModel.defineCount)
            case 9:
                DefineHobies(hobiesTags: defineUserViewModel.hobiesTags,selected: $defineUserViewModel.hobies, height:$defineUserViewModel.height, defineCount: $defineUserViewModel.defineCount)
            case 10:
                DefinePhoto(selected: $defineUserViewModel.selectedPhoto, defineCount: $defineUserViewModel.defineCount,completion: defineUserViewModel.AddUser)
       
            default:
                GenderProgress()
            }
            
            Spacer()
        }
    }
}

struct DefineUser_Previews: PreviewProvider {
    static var previews: some View {
        TestDefineUser()
    }
    
    struct TestDefineUser : View {
        @StateObject var homeViewModel : HomeViewModel = HomeViewModel()
        
        var body: some View {
            VStack {
                DefineUser(id: homeViewModel.currentUser.id, userData: homeViewModel.userData, userStorage: homeViewModel.userStorage, defineProgress: homeViewModel.isProgress)
            }
        }
    }
}

