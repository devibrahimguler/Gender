//
//  DefineUser.swift
//  Gender
//
//  Created by İbrahim Güler on 4.07.2023.
//

import SwiftUI

struct DefineUser: View {
    
    @EnvironmentObject var defineUserViewModel : DefineUserViewModel
    
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
            
            Divider()
            
            switch(defineUserViewModel.defineCount) {
            case 1:
                DefineNames()
                    .environmentObject(defineUserViewModel)
            case 2:
                DefineBirthDay()
                    .environmentObject(defineUserViewModel)
            case 3:
                DefineGender()
                    .environmentObject(defineUserViewModel)
            case 4:
                DefineOrientation()
                    .environmentObject(defineUserViewModel)
            case 5:
                DefineInterested()
                    .environmentObject(defineUserViewModel)
            case 6:
                DefineDistance()
                    .environmentObject(defineUserViewModel)
            case 7:
                DefineLook()
                    .environmentObject(defineUserViewModel)
            case 8:
                DefineSchool()
                    .environmentObject(defineUserViewModel)
            case 9:
                DefineHobies()
                    .environmentObject(defineUserViewModel)
            case 10:
                DefinePhoto()
                    .environmentObject(defineUserViewModel)
            default:
                RouterView()
                    .environmentObject(defineUserViewModel)
            }
            
            Spacer()
        }
    }
}

struct DefineUser_Previews: PreviewProvider {
    static var previews: some View {
        DefineUser()
            .environmentObject({ () -> DefineUserViewModel in return DefineUserViewModel() }() )
    }
}

