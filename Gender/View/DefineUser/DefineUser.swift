//
//  DefineUser.swift
//  Gender
//
//  Created by İbrahim Güler on 4.07.2023.
//

import SwiftUI

struct DefineUser: View {
    
    @EnvironmentObject var homeViewModel : HomeViewModel
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                ForEach(0...homeViewModel.defineCount, id: \.self) { i in
                    
                    Rectangle()
                        .fill(.red)
                        .frame(width: getRect().width / 10, height: 10)
                        .offset(x: homeViewModel.defineCount == i ? -200 : 0)
                        .animation(.linear, value: homeViewModel.defineCount)
                    
               
                }
                
            }
            .frame(width: getRect().width, alignment: .leading)
            
            Divider()
            
            switch(homeViewModel.defineCount) {
            case 1:
                DefineNames()
                    .environmentObject(homeViewModel)
            case 2:
                DefineBirthDay()
                    .environmentObject(homeViewModel)
            case 3:
                DefineGender()
                    .environmentObject(homeViewModel)
            case 4:
                DefineOrientation()
                    .environmentObject(homeViewModel)
            case 5:
                DefineInterested()
                    .environmentObject(homeViewModel)
            case 6:
                DefineDistance()
                    .environmentObject(homeViewModel)
            case 7:
                DefineLook()
                    .environmentObject(homeViewModel)
            case 8:
                DefineSchool()
                    .environmentObject(homeViewModel)
            case 9:
                DefineHobies()
                    .environmentObject(homeViewModel)
            case 10:
                DefinePhoto()
                    .environmentObject(homeViewModel)
            default:
                RouterView()
                    .environmentObject(homeViewModel)
            }
            
            Spacer()
        }
    }
}

struct DefineUser_Previews: PreviewProvider {
    static var previews: some View {
        DefineUser()
            .environmentObject({ () -> HomeViewModel in return HomeViewModel() }() )
    }
}

