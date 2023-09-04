//
//  Profile.swift
//  Gender
//
//  Created by İbrahim Güler on 2.07.2023.
//

import SwiftUI

struct Profile: View {
    
    @EnvironmentObject var mainViewModel : MainViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            if self.mainViewModel.photoProgress {
                GenderProgress()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 120, height: 120)
                    .padding(.top, 30)
            } else {
                
                 if let photo = mainViewModel.userPhoto.first {
                     photo.value
                         .resizable()
                         .scaledToFill()
                         .clipShape(Circle())
                         .frame(width: 120, height: 120)
                         .padding(.top, 30)
                 }
                 
            }
            
            VStack(spacing: 2) {
                Text("Hallo,")
                
                Text(mainViewModel.currentUser.name ?? "")
                    .font(.headline.bold())
            }
            
            Divider()
                .frame(height: 2)
                .background(.white)
                .padding(.horizontal, 20)
            
            Button {
                mainViewModel.isSettings = true
            } label: {
                Text("Settings")
            }
            .padding(.bottom, 100)
            
            Divider()
                .frame(height: 2)
                .background(.white)
                .padding(.horizontal, 20)
            
            Button {
                mainViewModel.logoutUser()
            } label: {
                Text("Logout")
            }

            Spacer()
        }
        .fullScreenCover(isPresented: $mainViewModel.isSettings) {
            SettingsView()
        }
        
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        TestProfile()
    }
    
    struct TestProfile : View {
        @StateObject var mainViewModel : MainViewModel = MainViewModel()
        
        var body: some View {
            VStack {
                Profile()
                    .environmentObject(mainViewModel)
                   
            }
            .foregroundColor(.black)
            .onAppear {
                self.mainViewModel.photoProgress = true
                self.mainViewModel.userPhoto = [:]
                self.mainViewModel.currentUser.name = "Selin"
                self.mainViewModel.imageDownloaderClient.downloadingImage(url: "Test/Test1.jpg", userStorage: UserStorage()) { result in
                    switch(result) {
                    case .failure(let err):
                        print(err)
                        self.mainViewModel.photoProgress = false
                    case .success(let image):
                        self.mainViewModel.userPhoto[0] = image
                        self.mainViewModel.photoProgress = false
                    }
                }
                
               
            }
        }
    }
    
}
