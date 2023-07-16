//
//  DefineLook.swift
//  Gender
//
//  Created by İbrahim Güler on 16.07.2023.
//

import SwiftUI

struct DefineLook: View {
    
    @EnvironmentObject var homeViewModel : HomeViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Button {
                homeViewModel.defineCount -= 1
            } label: {
                Image(systemName: "chevron.backward")
                    .font(.system(size: 50))
                    .padding(.bottom, 20)
                    .foregroundColor(.gray)
            }
            
            Text("What I'm looking for right now...")
                .font(.system(size: 40, weight: .bold))
                .padding(.bottom)
            
            Text("Share what you are looking for, find suitable matches!")
                .font(.callout)
                .padding(.bottom)
            
            
            HStack {
                Button {
                    
                } label: {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.gray)
                        .overlay {
                            VStack {
                                Text("💖")
                                    .font(.title)
                                
                                Text("USİ")
                                    .font(.title)
                            }
                            .foregroundColor(.black)
                        }
                }
                
                Button {
                    
                } label: {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.gray)
                        .overlay {
                            VStack {
                                Text("😍")
                                    .font(.title)
                                
                                Text("UİKO")
                                    .font(.title)
                            }
                            .foregroundColor(.black)
                        }
                    
                }
                
                Button {
                    
                } label: {
                    
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.gray)
                        .overlay {
                            VStack {
                                Text("🥂")
                                    .font(.title)
                                
                                Text("KİUO")
                                    .font(.title)
                            }
                            .foregroundColor(.black)
                        }
                    
                }
                
                
                
                
            }
            .frame(height: 150)
            
            Spacer(minLength: 10)
            
            Button {
                homeViewModel.defineCount += 1
            } label: {
                Text("Go On!")
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(.red)
                    .bold()
                    .foregroundColor(.white)
                    .cornerRadius(50)
                
            }
            
        }
        .padding(20)
    }
}

struct DefineLook_Previews: PreviewProvider {
    static var previews: some View {
        DefineLook()
            .environmentObject({ () -> HomeViewModel in return HomeViewModel() }() )
    }
}
