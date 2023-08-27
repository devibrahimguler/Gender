//
//  HomeView.swift
//  Gender
//
//  Created by İbrahim Güler on 30.06.2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeViewModel : HomeViewModel = HomeViewModel()
    
    var body: some View {
        if homeViewModel.isProgress {
            GenderProgress()
                .environmentObject(homeViewModel)
        } else {
            if homeViewModel.isConnected {
                if (homeViewModel.defineCount == 11) {
                    RouterView()
                        .environmentObject(homeViewModel)
                } else {
                    DefineUser()
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
    }
}
