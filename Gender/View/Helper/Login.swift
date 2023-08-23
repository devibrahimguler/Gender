//
//  Login.swift
//  Gender
//
//  Created by İbrahim Güler on 1.07.2023.
//

import SwiftUI

struct Login: View {
    
    @EnvironmentObject var homeViewModel : HomeViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            
            VStack{
                
                Spacer(minLength: 10)
                
                Text("Gender")
                    .foregroundColor(.white)
                    .font(.system(size: 40,weight: .bold, design: .rounded))
                    .frame( width: getRect().width, alignment: .center)
                    .offset(y: homeViewModel.isFocused ? -300 : 0)
                    .animation(.easeInOut, value: homeViewModel.isFocused)
                
            }
            
            VStack(alignment: .leading) {

                VStack {
                    
                    HStack {
                        
                        Image(systemName: "envelope")
                            .foregroundColor(.black)
                            .frame(width: 44, height: 44)
                            .background(.thinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 5)
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
                            .foregroundColor(.black)
                            .frame(width: 44, height: 44)
                            .background(.thinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 5)
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
                }
                .frame(height: 136)
                .frame(maxWidth: 712)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: .black.opacity(0.15), radius: 20, x: 0, y: 20)
                .padding()
                
                Button(action: {
                    homeViewModel.loginUser()
                }) {
                    Text("Log in")
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity)
                .padding(12)
                .padding(.horizontal, 20)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(color: .black.opacity(0.15), radius: 20, x: 0, y: 20)
                .padding()
           
                
                HStack {
                    
                    Button(action: {
    
                    }) {
                        Text("Forgot password ?")
                            .font(.subheadline)
                            .foregroundColor(.black)
                    }
                    .padding(2)

                    
                    Spacer()
                    
                    Button(action: {
                        homeViewModel.isLogin = false
                    }) {
                        Text("Click for Register !")
                            .font(.subheadline)
                            .foregroundColor(.black)
                    }
                    .padding(2)
                }
                .padding(.horizontal, 30)

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .padding()
            
        }
        .offset(x:homeViewModel.isLogin ? 0 : getRect().width * 2, y: homeViewModel.isFocused ? -300 : 0)
        .animation(.easeInOut, value: homeViewModel.isFocused)
        .animation(.easeInOut, value: homeViewModel.isLogin)
        .background(LinearGradient(colors: [homeViewModel.startColor, homeViewModel.endColor], startPoint: .leading, endPoint: .trailing))
        .onTapGesture {
            homeViewModel.isFocused = false
            
        }
        .background()
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        TestLogin()
    }
    
    struct TestLogin : View {
        @StateObject var homeViewModel : HomeViewModel = HomeViewModel()
        
        var body: some View {
            VStack {
                Login()
                    .environmentObject(homeViewModel)
            }
        }
    }
}
