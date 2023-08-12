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
            if let photo = homeViewModel.selectedPhoto.first {
                if let data = photo {
                    Image(uiImage: data)
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 120, height: 120)
                        .padding(.top, 30)
                }
            } else {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 120, height: 120)
                    .padding(.top, 30)
            }
            
          
           
            
            VStack(spacing: 2) {
                Text("Hallo,")
                    .foregroundColor(homeViewModel.bG)
                
                Text(homeViewModel.currentUser.name)
                    .font(.headline.bold())
                    .foregroundColor(homeViewModel.bG)
            }
            
            Divider()
                .frame(height: 2)
                .background(homeViewModel.bG)
                .padding(.horizontal, 20)
            
            Button {
                homeViewModel.isSettings = true
            } label: {
                Text("Settings")
                    .foregroundColor(homeViewModel.bG)
            }
            .padding(.bottom, 100)
            
            Divider()
                .frame(height: 2)
                .background(homeViewModel.bG)
                .padding(.horizontal, 20)
            
            Button {
                homeViewModel.logoutUser()
            } label: {
                Text("Logout")
                    .foregroundColor(homeViewModel.bG)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background(homeViewModel.orange)
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
