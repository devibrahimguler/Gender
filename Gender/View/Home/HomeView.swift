//
//  RouterView.swift
//  Gender
//
//  Created by İbrahim Güler on 2.07.2023.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var mainViewModel : MainViewModel
    
    
    var startColor : Color
    var endColor : Color
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            
            Profile()
                .environmentObject(mainViewModel)
                .foregroundColor(.white)
                .frame(width: getRect().width / 2)
                .offset(x: mainViewModel.isProfile ? 0: -350)
                .animation(.spring().delay(0.1), value: mainViewModel.isProfile)
          
            Home(startColor: startColor, endColor: endColor)
                .environmentObject(mainViewModel)
            
            
        }
        .background(LinearGradient(colors: [startColor, endColor], startPoint: .leading, endPoint: .trailing))
        

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        TestHomeView()
    }
    
    struct TestHomeView : View {
        @StateObject var mainViewModel : MainViewModel = MainViewModel()
        
        
        var startColor : Color = Color("Start")
        var endColor : Color = Color("End")
        
        var body: some View {
            VStack {
                HomeView(startColor: startColor, endColor: endColor)
                    .environmentObject(mainViewModel)
            }
        }
    }
}
