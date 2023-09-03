//
//  HomeView.swift
//  Gender
//
//  Created by İbrahim Güler on 30.06.2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeViewModel : HomeViewModel = HomeViewModel()

    var startColor : Color = Color("Start")
    var endColor : Color = Color("End")

    var body: some View {
        if homeViewModel.isProgress {
            GenderProgress()
        } else {
            if homeViewModel.isConnected {
                if homeViewModel.defineUser {
                    RouterView(startColor: startColor, endColor: endColor)
                        .environmentObject(homeViewModel)
                } else {
                    DefineUser(id: homeViewModel.currentUser.id, userData: homeViewModel.userData, userStorage: homeViewModel.userStorage, defineProgress: homeViewModel.isProgress)
                }
            } else {
                EntryView(userConnection : homeViewModel.userConnection, entryProgress: $homeViewModel.isProgress, isConnected: $homeViewModel.isConnected, startColor: startColor, endColor: endColor)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
