//
//  RouterView.swift
//  Gender
//
//  Created by İbrahim Güler on 2.07.2023.
//

import SwiftUI

struct RouterView: View {
    
    @EnvironmentObject var homeViewModel : HomeViewModel
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            
            Profile()
                .environmentObject(homeViewModel)
                .foregroundColor(.white)
                .frame(width: getRect().width / 2)
                .offset(x: homeViewModel.isProfile ? 0: -350)
                .animation(.spring().delay(0.1), value: homeViewModel.isProfile)
          
            Home()
                .environmentObject(homeViewModel)
            
            
        }
        .background(LinearGradient(colors: [homeViewModel.startColor, homeViewModel.endColor], startPoint: .leading, endPoint: .trailing))
        

    }
}

struct RouterView_Previews: PreviewProvider {
    static var previews: some View {
        TestRouterView()
    }
    
    struct TestRouterView : View {
        @StateObject var homeViewModel : HomeViewModel = HomeViewModel()
        
        var body: some View {
            VStack {
                RouterView()
                    .environmentObject(homeViewModel)
            }
        }
    }
}
