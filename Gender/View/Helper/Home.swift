//
//  Home.swift
//  Gender
//
//  Created by İbrahim Güler on 2.07.2023.
//

import SwiftUI

struct Home: View {
    
    @EnvironmentObject var homeViewModel : HomeViewModel
    
    var startColor : Color
    var endColor : Color
    
    var body: some View {
        VStack {
            
            
            HStack {
                Button {
                    homeViewModel.isProfile.toggle()
                } label: {
                    RoundedRectangle(cornerRadius: 7)
                        .fill(LinearGradient(colors: [startColor, endColor], startPoint: .leading, endPoint: .trailing))
                        .frame(width: 40, height: 40)
                        .overlay {
                            Image(systemName: homeViewModel.isProfile ? "multiply": "line.3.horizontal")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                        }
                    
                    
                }
                
                Spacer()
            }
            
            Spacer()
            
            PhotoSelection()
                .environmentObject(homeViewModel)
            
            Spacer()
            
     
            
        }

        .padding(30)
        .background(Color.white.cornerRadius(homeViewModel.isProfile ? 50 : .zero).edgesIgnoringSafeArea(.all))
        .onTapGesture {
            homeViewModel.isProfile = false
        }
        .frame(width:  homeViewModel.isProfile ? getRect().width : nil,  height:  homeViewModel.isProfile ? getRect().height / 1.2 : nil)

        .offset(x: homeViewModel.isProfile ? getRect().width / 2 : 0)
        .animation(.spring().delay(0.1), value: homeViewModel.isProfile)
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        TestHome()
    }
    
    struct TestHome : View {
        @StateObject var homeViewModel : HomeViewModel = HomeViewModel()
        
        var startColor : Color = Color("Start")
        var endColor : Color = Color("End")
        
        var body: some View {
            VStack {
                Home(startColor: startColor, endColor: endColor)
                    .environmentObject(homeViewModel)
            }
        }
    }
}
