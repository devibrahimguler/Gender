//
//  Profile.swift
//  Gender
//
//  Created by İbrahim Güler on 2.07.2023.
//

import SwiftUI

struct Profile: View {
    
    @EnvironmentObject var homeViewModel : HomeViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(30)
            
            VStack(spacing: 2) {
                Text("Hallo,")
                Text(homeViewModel.currentUser.name)
                    .font(.headline.bold())
            }
            
            Divider()
                .frame(height: 2)
                .background(.black)
                .padding(.horizontal, 20)
            
            Button {
                
            } label: {
                Text("Settings")
                    .foregroundColor(.black)
            }
            
            Divider()
                .frame(height: 2)
                .background(.black)
                .padding(.horizontal, 20)
            
            Button {
                homeViewModel.logoutUser()
            } label: {
                Text("Logout")
                    .foregroundColor(.black)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)

        
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
