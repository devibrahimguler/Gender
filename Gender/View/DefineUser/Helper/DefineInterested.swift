//
//  DefineInterested.swift
//  Gender
//
//  Created by İbrahim Güler on 16.07.2023.
//

import SwiftUI

struct DefineInterested: View {
    
    @Binding var selected : String
    @Binding var defineCount : Int
    
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

            Text("Who are you interested in seeing?")
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
            
            Button {
                selected = "Everyone"
            } label: {
                
                RoundedRectangle(cornerRadius: 50)
                    .stroke(lineWidth: 2)
                    .overlay {
                        Text("Everyone")
                            .font(.largeTitle)
                            .bold()
                    }
                    .frame(height: 60)
                    .foregroundColor(selected == "Everyone" ? .purple : .gray)
            }
            
            Spacer(minLength: 10)
            
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

struct DefineInterested_Previews: PreviewProvider {
    static var previews: some View {
        TestDefineInterested()
    }
    
    struct TestDefineInterested : View {
        @ObservedObject var defineUserViewModel : DefineUserViewModel = DefineUserViewModel(userData: UserData(), userStorage: UserStorage(), defineProgress: true)
        
        var body: some View {
            VStack {
                DefineInterested(selected: $defineUserViewModel.interest, defineCount: $defineUserViewModel.defineCount)
            }
        }
    }
}
