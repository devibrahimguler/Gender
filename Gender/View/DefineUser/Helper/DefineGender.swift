//
//  DefineGender.swift
//  Gender
//
//  Created by İbrahim Güler on 16.07.2023.
//

import SwiftUI

struct DefineGender: View {
    
    @Binding var gender : String
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
                gender = "Female"
            } label: {
                RoundedRectangle(cornerRadius: 50)
                    .stroke(lineWidth: 2)
                    .overlay {
                        Text("Female")
                            .font(.largeTitle)
                            .bold()
                    }
                    .frame(height: 60)
                    .foregroundColor(gender == "Female" ? .red : .gray)
            }
            
            Button {
                gender = "Male"
            } label: {
                
                RoundedRectangle(cornerRadius: 50)
                    .stroke(lineWidth: 2)
                    .overlay {
                        Text("Male")
                            .font(.largeTitle)
                            .bold()
                    }
                    .frame(height: 60)
                    .foregroundColor(gender == "Male" ? .blue : .gray)
     
                
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
                    .background(.red)
                    .bold()
                    .foregroundColor(.white)
                    .cornerRadius(50)
             
            }
      
        }
        .padding(20)
    }
}

struct DefineGender_Previews: PreviewProvider {
    static var previews: some View {
        TestDefineGender()
    }
    
    struct TestDefineGender : View {
        @ObservedObject var defineUserViewModel : DefineUserViewModel = DefineUserViewModel()
        
        var body: some View {
            VStack {
                DefineGender(gender: $defineUserViewModel.gender, defineCount: $defineUserViewModel.defineCount, isVisible: $defineUserViewModel.isVisibleGender)
            }
        }
    }
}
