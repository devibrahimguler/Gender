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
                .frame(width: getRect().width / 2)
                .environmentObject(homeViewModel)
                .offset(x: homeViewModel.isProfile ? 0: -350)
                .animation(.spring().delay(0.1), value: homeViewModel.isProfile)
            
            Home()
                 .frame(width:  homeViewModel.isProfile ? getRect().width : nil,  height:  homeViewModel.isProfile ? getRect().height / 1.2 : nil)
               .environmentObject(homeViewModel)
               .cornerRadius(homeViewModel.isProfile ? 50 : 0)
               .offset(x: homeViewModel.isProfile ? getRect().width / 2 : 0)
               .animation(.spring().delay(0.1), value: homeViewModel.isProfile)

            
        }
        .background( .red)

    }
}

struct RouterView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
