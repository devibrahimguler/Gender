//
//  GenderProgress.swift
//  Gender
//
//  Created by İbrahim Güler on 1.07.2023.
//

import SwiftUI

struct GenderProgress: View {
    
    @EnvironmentObject var homeViewModel : HomeViewModel
    
    var body: some View {
        
        VStack{
            
            Text("Gender")
                .foregroundColor(.black)
                .font(.system(size: 40,weight: .bold, design: .rounded))
                .frame( width: getRect().width, alignment: .center)
                .rotationEffect(Angle(degrees: homeViewModel.rotation))
                .animation(.easeOut.repeatForever(), value: homeViewModel.rotation)
            
        }.onAppear {
            homeViewModel.rotation = homeViewModel.rotation == 30 ? homeViewModel.rotation - 60 : homeViewModel.rotation + 60
        }
    }
}

struct GenderProgress_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
