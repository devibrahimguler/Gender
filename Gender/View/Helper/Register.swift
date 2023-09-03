//
//  Register.swift
//  Gender
//
//  Created by İbrahim Güler on 1.07.2023.
//

import SwiftUI

struct Register: View {
    
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
            
            VStack {
                
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
                    
                    Divider().padding(.leading, 80)
                    
                    

                }
                .frame(height: 136)
                .frame(maxWidth: 712)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: .white.opacity(0.15), radius: 20, x: 0, y: 20)
                .padding()
                
                Button(action: {
                    complation()
                }) {
                    Text("Register")
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity)
                .padding(12)
                .padding(.horizontal, 20)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(color: .black.opacity(0.15), radius: 20, x: 0, y: 20)
                .padding()
                
                Button(action: {
                    self.isLogin = true
                }) {
                    Text("Click for Log in !")
                        .font(.subheadline)
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 30)
                

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .padding()
            
        }
        .offset(y: self.isFocused ? -300 : 0)
        .animation(.easeInOut, value: self.isFocused)
        .background(LinearGradient(colors: [startColor, endColor], startPoint: .leading, endPoint: .trailing))
        .onTapGesture {
            self.isFocused = false
            
        }
        .background()
    }
}

struct Register_Previews: PreviewProvider {
    static var previews: some View {
        TestRegister()
    }
    
    struct TestRegister : View {
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
                Register(startColor: startColor, endColor: endColor, email: $entryViewModel.email, password: $entryViewModel.password, isFocused: $entryViewModel.isFocused, isLogin: $entryViewModel.isLogin)
                {
                    entryViewModel.registerUser()
                }
            }
        }
    }
}
