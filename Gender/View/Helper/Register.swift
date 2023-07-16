//
//  Register.swift
//  Gender
//
//  Created by İbrahim Güler on 1.07.2023.
//

import SwiftUI

struct Register: View {
    
    @EnvironmentObject var homeViewModel : HomeViewModel
    
    private let black : Color = Color("Black")
    private let cardBG : Color = Color("CardBG")
    private let bG : Color = Color("BG")
    
    var body: some View {
        VStack(alignment: .leading) {
            
            VStack{
                
                Spacer(minLength: 10)
                
                Text("Gender")
                    .foregroundColor(black)
                    .font(.system(size: 40,weight: .bold, design: .rounded))
                    .frame( width: getRect().width, alignment: .center)
                    .offset(y: homeViewModel.isFocused ? -300 : 0)
                    .animation(.easeInOut, value: homeViewModel.isFocused)
                
            }
            
            VStack {
                
                VStack {
                    
                    HStack {
                        
                        Image(systemName: "envelope")
                            .foregroundColor(black)
                            .frame(width: 44, height: 44)
                            .background(.thinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: black.opacity(0.15), radius: 5, x: 0, y: 5)
                            .padding(.leading)
                        
                        TextField("Your Email".uppercased(), text: $homeViewModel.email)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .font(.subheadline)
                            .padding(.leading)
                            .frame(height: 44)
                            .onTapGesture {
                                homeViewModel.isFocused = true
                            }
                    }
                    
                    Divider().padding(.leading, 80)
                    
                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(black)
                            .frame(width: 44, height: 44)
                            .background(.thinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: black.opacity(0.15), radius: 5, x: 0, y: 5)
                            .padding(.leading)
                        
                        SecureField("Password".uppercased(), text: $homeViewModel.password)
                            .keyboardType(.default)
                            .font(.subheadline)
                            .padding(.leading)
                            .frame(height: 44)
                            .onTapGesture {
                                homeViewModel.isFocused = true
                            }
                    }
                    
                    Divider().padding(.leading, 80)
                    
                    

                }
                .frame(height: 136)
                .frame(maxWidth: 712)
                .background(cardBG)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: black.opacity(0.15), radius: 20, x: 0, y: 20)
                .padding()
                
                Button(action: {
                    homeViewModel.registerUser()
                }) {
                    Text("Register")
                        .foregroundColor(black)
                }
                .frame(maxWidth: .infinity)
                .padding(12)
                .padding(.horizontal, 20)
                .background(cardBG)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(color: black.opacity(0.15), radius: 20, x: 0, y: 20)
                .padding()
                
                Button(action: {
                    homeViewModel.isLogin = true
                }) {
                    Text("Click for Log in !")
                        .font(.subheadline)
                        .foregroundColor(black)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 30)
                

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .padding()
            
        }
        .offset(y: homeViewModel.isFocused ? -300 : 0)
        .animation(.easeInOut, value: homeViewModel.isFocused)
        .background(bG)
        .onTapGesture {
            homeViewModel.isFocused = false
            
        }
        .background()
    }
}

struct Register_Previews: PreviewProvider {
    static var previews: some View {
        Register()
            .environmentObject({ () -> HomeViewModel in return HomeViewModel() }() )
    }
}
