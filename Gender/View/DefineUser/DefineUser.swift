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
                        .frame(width: getRect().width / 5, height: 10)
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
                DefinePhoto()
                    .environmentObject(homeViewModel)
            case 4:
                DefineHobies()
                    .environmentObject(homeViewModel)
            case 5:
                DefinePersonnelData()
                    .environmentObject(homeViewModel)
            default:
                RouterView()
                    .environmentObject(homeViewModel)
            }

            HStack {
                Spacer()
                
                Button {
                    homeViewModel.defineCount += 1
                } label: {
                    Text("Submit")
                }

            }
            .padding(20)
            
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

