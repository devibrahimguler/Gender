//
//  HomeView.swift
//  Gender
//
//  Created by İbrahim Güler on 30.06.2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeViewModel : HomeViewModel = HomeViewModel()
    @StateObject var defineUserViewModel : DefineUserViewModel = DefineUserViewModel()
    
    var body: some View {
        if homeViewModel.isProgress {
            
            GenderProgress()
                .environmentObject(homeViewModel)
            
        } else {
            if homeViewModel.isConnected {
                if defineUserViewModel.isDefineUser {
                    RouterView()
                        .environmentObject(homeViewModel)
                } else {
                    DefineUser()
                        .environmentObject(defineUserViewModel)
                }
                
            } else {
                EntryView()
                    .environmentObject(homeViewModel)
            }
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject({ () -> HomeViewModel in return HomeViewModel() }() )
    }
}
