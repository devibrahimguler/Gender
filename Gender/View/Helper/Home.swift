//
//  Home.swift
//  Gender
//
//  Created by İbrahim Güler on 2.07.2023.
//

import SwiftUI

struct Home: View {
    
    @EnvironmentObject var homeViewModel : HomeViewModel
    
    private let black : Color = Color("Black")
    private let orange : Color = Color("Orange")
    private let bG : Color = Color("BG")
    
    var body: some View {
        VStack {
            
            
            HStack {
                Button {
                    homeViewModel.isProfile.toggle()
                } label: {
                    RoundedRectangle(cornerRadius: 7)
                        .fill(orange)
                        .frame(width: 40, height: 40)
                        .overlay {
                            Image(systemName: homeViewModel.isProfile ? "multiply": "line.3.horizontal")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .foregroundColor(bG)
                        }
                    
                    
                }
                
                Spacer()
            }
            
            Spacer()
            
            RoundedRectangle(cornerRadius: 25)
                .stroke(lineWidth: 3)
                .overlay {
                    if homeViewModel.isStartSearched {
                        
                    } else {
                        Button {
                            homeViewModel.isStartSearched = true
                        } label: {
                            ZStack {
                                Text("Click for Start")
                                    .font(.system(size: 100, design: .rounded).bold())
                                    .foregroundColor(black)
                                
                                Image(systemName: "i.square")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(20)
                                    .blur(radius: homeViewModel.isStartSearched ? 0 : 20)
                                    .foregroundColor(black)
                            }
                        }
                        
                    }
                    
                }
                .padding(.vertical, 30)
            
            
            Spacer()
            
            HStack(spacing: 50) {
                Image(systemName: "heart.slash.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .foregroundColor(.red)
                
                Image(systemName: "bolt.heart.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .foregroundColor(.blue)
                
                Image(systemName: "suit.heart.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .foregroundColor(.green)
            }
            
        }
        .padding(30)
        .background(bG)
        .onTapGesture {
            homeViewModel.isProfile = false
        }
        .frame(width:  homeViewModel.isProfile ? getRect().width : nil,  height:  homeViewModel.isProfile ? getRect().height / 1.2 : nil)
        .cornerRadius(homeViewModel.isProfile ? 50 : 0)
        .offset(x: homeViewModel.isProfile ? getRect().width / 2 : 0)
        .animation(.spring().delay(0.1), value: homeViewModel.isProfile)
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        RouterView()
            .environmentObject({ () -> HomeViewModel in return HomeViewModel() }() )
    }
}
