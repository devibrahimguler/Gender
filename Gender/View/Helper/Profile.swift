//
//  Profile.swift
//  Gender
//
//  Created by İbrahim Güler on 2.07.2023.
//

import SwiftUI

struct Profile: View {
    
    @EnvironmentObject var homeViewModel : HomeViewModel
    
    private let bG : Color = Color("BG")
    private let orange : Color = Color("Orange")
    
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(30)
                .foregroundColor(bG)
            
            VStack(spacing: 2) {
                Text("Hallo,")
                    .foregroundColor(bG)
                
                Text(homeViewModel.currentUser.name)
                    .font(.headline.bold())
                    .foregroundColor(bG)
            }
            
            Divider()
                .frame(height: 2)
                .background(bG)
                .padding(.horizontal, 20)
            
            Button {
                homeViewModel.isSettings = true
            } label: {
                Text("Settings")
                    .foregroundColor(bG)
            }
            .padding(.bottom, 100)
            
            Divider()
                .frame(height: 2)
                .background(bG)
                .padding(.horizontal, 20)
            
            Button {
                homeViewModel.logoutUser()
            } label: {
                Text("Logout")
                    .foregroundColor(bG)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background(orange)
        .fullScreenCover(isPresented: $homeViewModel.isSettings) {
            SettingsView()
        }
        
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
            .environmentObject({ () -> HomeViewModel in return HomeViewModel() }() )
    }
}
