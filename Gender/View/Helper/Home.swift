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
                        .fill(homeViewModel.orange)
                        .frame(width: 40, height: 40)
                        .overlay {
                            Image(systemName: homeViewModel.isProfile ? "multiply": "line.3.horizontal")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .foregroundColor(homeViewModel.bG)
                        }
                    
                    
                }
                
                Spacer()
            }
            
            Spacer()
            
            VStack {
                if homeViewModel.isStartSearched {
                    if homeViewModel.randomPhoto.count > 0 {
                        if let data = homeViewModel.randomPhoto[homeViewModel.photoId] {
                            VStack {
                                Image(uiImage: data)
                                    .resizable()
                                    .cornerRadius(30)
                                
                                Spacer()
                                HStack {
                                    ForEach(0...homeViewModel.randomPhoto.count - 1, id:\.self) { i in
                                        
                                        Button {
                                            homeViewModel.photoId = i
                                        } label: {
                                            Circle()
                                                .foregroundColor(homeViewModel.photoId == i ? .blue : .gray)
                                                .animation(.easeInOut, value: homeViewModel.photoId == i)
                                                .frame(width: 20)
                                            
                                        }
                                    }
                                }
                            }
                            
                        }
                    }
                }
                else {
                    Button {
                        homeViewModel.getUser()
                        homeViewModel.isStartSearched = true
                    } label: {
                        ZStack {
                            Text("Click for Start")
                                .font(.system(size: 100, design: .rounded).bold())
                                .foregroundColor(homeViewModel.black)
                            
                            Image(systemName: "i.square")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(20)
                                .blur(radius: homeViewModel.isStartSearched ? 0 : 20)
                                .foregroundColor(homeViewModel.black)
                        }
                    }
                    
                }
            }
            .padding(.vertical, 30)
            
            
            Spacer()
            
            HStack(spacing: 50) {
                Image(systemName: "xmark")
                    .resizable()
                    .bold()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35, height: 35)
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
        .background(homeViewModel.bG)
        .onTapGesture {
            homeViewModel.isProfile = false
        }
        .frame(width:  homeViewModel.isProfile ? getRect().width : nil,  height:  homeViewModel.isProfile ? getRect().height / 1.2 : nil)
        .cornerRadius(50)
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
