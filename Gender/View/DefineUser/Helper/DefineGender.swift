//
//  DefineGender.swift
//  Gender
//
//  Created by İbrahim Güler on 16.07.2023.
//

import SwiftUI

struct DefineGender: View {
    
    @Binding var selected : String
    @Binding var defineCount : Int
    @Binding var isVisible : Bool
    
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Button {
                defineCount -= 1
            } label: {
                Image(systemName: "chevron.backward")
                    .font(.system(size: 50))
                    .foregroundColor(.gray)
            }
            .padding(.bottom)

            Text("What is your gender?")
                .font(.system(size: 40, weight: .bold))
            
            Button {
                selected = "Female"
            } label: {
                RoundedRectangle(cornerRadius: 50)
                    .stroke(lineWidth: 2)
                    .overlay {
                        Text("Female")
                            .font(.largeTitle)
                            .bold()
                    }
                    .frame(height: 60)
                    .foregroundColor(selected == "Female" ? .red : .gray)
            }
            
            Button {
                selected = "Male"
            } label: {
                
                RoundedRectangle(cornerRadius: 50)
                    .stroke(lineWidth: 2)
                    .overlay {
                        Text("Male")
                            .font(.largeTitle)
                            .bold()
                    }
                    .frame(height: 60)
                    .foregroundColor(selected == "Male" ? .blue : .gray)
     
                
            }
            
            Spacer(minLength: 10)
            
            Divider()
            
            Button {
                isVisible.toggle()
            } label: {
                
                HStack {
                    if isVisible {
                        Image(systemName: "checkmark.square")
                    } else {
                        Image(systemName: "square")
                    }
                    
                    Text("Profilimde cinsiyetimi göster")
                        .font(.headline)
                }
                .foregroundColor(.gray)
     
                
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.vertical)
            
            Button {
                defineCount += 1
            } label: {
                Text("Go On!")
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(selected != "" ? .red : .gray)
                    .bold()
                    .foregroundColor(.white)
                    .cornerRadius(50)
             
            }
            .disabled(selected == "")
      
        }
        .padding(20)
    }
}

struct DefineGender_Previews: PreviewProvider {
    static var previews: some View {
        TestDefineGender()
    }
    
    struct TestDefineGender : View {
        @ObservedObject var defineUserViewModel : DefineUserViewModel = DefineUserViewModel(userData: UserData(), userStorage: UserStorage(), defineProgress: true)
        
        var body: some View {
            VStack {
                DefineGender(selected: $defineUserViewModel.gender, defineCount: $defineUserViewModel.defineCount, isVisible: $defineUserViewModel.isVisibleGender)
            }
        }
    }
}
