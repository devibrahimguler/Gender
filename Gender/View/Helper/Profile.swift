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
            if self.homeViewModel.photoProgress {
                GenderProgress()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 120, height: 120)
                    .padding(.top, 30)
            } else {
                if let photo = homeViewModel.selectedPhoto.first {
                    Image(uiImage: photo.value)
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 120, height: 120)
                        .padding(.top, 30)
                }
            }
            
            VStack(spacing: 2) {
                Text("Hallo,")
                
                Text(homeViewModel.currentUser.name ?? "")
                    .font(.headline.bold())
            }
            
            Divider()
                .frame(height: 2)
                .background(.white)
                .padding(.horizontal, 20)
            
            Button {
                homeViewModel.isSettings = true
            } label: {
                Text("Settings")
            }
            .padding(.bottom, 100)
            
            Divider()
                .frame(height: 2)
                .background(.white)
                .padding(.horizontal, 20)
            
            Button {
                homeViewModel.logoutUser()
            } label: {
                Text("Logout")
            }

            Spacer()
        }
        .fullScreenCover(isPresented: $homeViewModel.isSettings) {
            SettingsView()
        }
        
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        TestProfile()
    }
    
    struct TestProfile : View {
        @StateObject var homeViewModel : HomeViewModel = HomeViewModel()
        
        var body: some View {
            VStack {
                Profile()
                    .environmentObject(homeViewModel)
                   
            }
            .foregroundColor(.black)
            .onAppear {
                self.homeViewModel.currentUser.name = "İbrahim"
                self.homeViewModel.downloadImage(p: "c4oWyBlrrgUAZszbkhGnIFWgVh12/c4oWyBlrrgUAZszbkhGnIFWgVh121.jpg", index: 0)
                
               
            }
        }
    }
    
}
