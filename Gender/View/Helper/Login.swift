//
//  Login.swift
//  Gender
//
//  Created by İbrahim Güler on 1.07.2023.
//

import SwiftUI

struct Login: View {
    
    var startColor : Color
    var endColor : Color
    
    @Binding var email : String
    @Binding var password : String
    @Binding var isFocused : Bool
    @Binding var isLogin : Bool
    var complation : () -> ()
    
    var body: some View {
        VStack(alignment: .leading) {
            
            VStack{
                
                Spacer(minLength: 10)
                
                Text("Gender")
                    .foregroundColor(.white)
                    .font(.system(size: 40,weight: .bold, design: .rounded))
                    .frame( width: getRect().width, alignment: .center)
                    .offset(y: self.isFocused ? -300 : 0)
                    .animation(.easeInOut, value: self.isFocused)
                
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
                        
                        TextField("Your Email".uppercased(), text: $email)
                            .autocorrectionDisabled(true)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .font(.subheadline)
                            .padding(.leading)
                            .frame(height: 44)
                            .onTapGesture {
                                self.isFocused = true
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
                        
                        SecureField("Password".uppercased(), text: $password)
                            .autocorrectionDisabled(true)
                            .keyboardType(.default)
                            .font(.subheadline)
                            .padding(.leading)
                            .frame(height: 44)
                            .onTapGesture {
                                self.isFocused = true
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
                    complation()
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
                        self.isLogin = false
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
        .offset(x:self.isLogin ? 0 : getRect().width * 2, y: self.isFocused ? -300 : 0)
        .animation(.easeInOut, value: self.isFocused)
        .animation(.easeInOut, value: self.isLogin)
        .background(LinearGradient(colors: [startColor, endColor], startPoint: .leading, endPoint: .trailing))
        .onTapGesture {
            self.isFocused = false
            
        }
        .background()
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        TestLogin()
    }
    
    struct TestLogin : View {
        @ObservedObject var entryViewModel : EntryViewModel
       
        
        var startColor : Color = Color("Start")
        var endColor : Color = Color("End")
        
        init() {
            @State var progress : Bool = false
            @State var isConnected : Bool = false
            self.entryViewModel = EntryViewModel(userConnection: UserConnection(), entryProgress: $progress, isConnected: $isConnected)
        }
        
        var body: some View {
            VStack {
                Login(startColor: startColor, endColor: endColor, email: $entryViewModel.email, password: $entryViewModel.password, isFocused: $entryViewModel.isFocused, isLogin: $entryViewModel.isLogin) {
                    entryViewModel.loginUser()
                }
                
            }
        }
    }
}
