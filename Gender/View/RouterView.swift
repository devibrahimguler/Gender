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
                .frame(width: getRect().width / 2)
                .offset(x: homeViewModel.isProfile ? 0: -350)
                .animation(.spring().delay(0.1), value: homeViewModel.isProfile)
          
            
            homeViewModel.bG
                .frame(width:  homeViewModel.isProfile ? getRect().width : nil,  height:  homeViewModel.isProfile ? getRect().height / 1.2 : nil)
                .cornerRadius( 50 )
                .offset(x: homeViewModel.isProfile ? getRect().width / 2 : 0)
                .animation(.spring().delay(0.1), value: homeViewModel.isProfile)
                .ignoresSafeArea()
            
            Home()
                .environmentObject(homeViewModel)
            
        }
        .background( homeViewModel.orange)
        

    }
}

struct RouterView_Previews: PreviewProvider {
    static var previews: some View {
        RouterView()
            .environmentObject({ () -> HomeViewModel in return HomeViewModel() }() )
    }
}
