//
//  Home.swift
//  Gender
//
//  Created by İbrahim Güler on 2.07.2023.
//

import SwiftUI

struct Home: View {
    
    @EnvironmentObject var homeViewModel : HomeViewModel
    
    var body: some View {
        VStack {
            

            HStack {
                Button {
                    homeViewModel.isProfile.toggle()
                } label: {
                   RoundedRectangle(cornerRadius: 7)
                        .fill(.cyan)
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
            
            Text("Home")
            
            Spacer()
            
        }
        .padding(30)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
        .onTapGesture {
            homeViewModel.isProfile = false
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
