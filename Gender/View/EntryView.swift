//
//  EntryView.swift
//  Gender
//
//  Created by İbrahim Güler on 1.07.2023.
//

import SwiftUI

struct EntryView: View {
    @EnvironmentObject var homeViewModel : HomeViewModel
    
    var body: some View {
        ZStack {
            Login()
                .environmentObject(homeViewModel)
                .offset(x:homeViewModel.isLogin ? 0 : getRect().width * 2)
                .animation(.easeInOut, value: homeViewModel.isLogin)
            
            Register()
                .offset(x:homeViewModel.isLogin ? -getRect().width * 2 : 0)
                .animation(.easeInOut, value: homeViewModel.isLogin)
                .environmentObject(homeViewModel)

        }
        .background(LinearGradient(colors: [homeViewModel.startColor, homeViewModel.endColor], startPoint: .leading, endPoint: .trailing))
    }
}

struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        TestEntryView()
    }
    struct TestEntryView : View {
        @StateObject var homeViewModel : HomeViewModel = HomeViewModel()
        
        var body: some View {
            VStack {
                EntryView()
                    .environmentObject(homeViewModel)
            }
        }
    }
}

extension View {
    func getRect() -> CGSize {
        return UIScreen.main.bounds.size
    }
}
