//
//  DefineLook.swift
//  Gender
//
//  Created by İbrahim Güler on 16.07.2023.
//

import SwiftUI

struct DefineLook: View {
    
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
            
            Text("What I'm looking for right now...")
                .font(.system(size: 40, weight: .bold))
                .padding(.bottom)
            
            Text("Share what you are looking for, find suitable matches!")
                .font(.callout)
                .padding(.bottom)
            
            
            HStack {
                LookSelectButton(selected: $selected, header: "💖", text: "USİ")
      
                LookSelectButton(selected: $selected, header: "😍", text: "UİKO")
            
                LookSelectButton(selected: $selected, header: "🥂", text: "KİUO")
                
            }
            .frame(height: 150)
            
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

struct DefineLook_Previews: PreviewProvider {
    static var previews: some View {
        TestDefineLook()
    }
    
    struct TestDefineLook : View {
        @ObservedObject var defineUserViewModel : DefineUserViewModel = DefineUserViewModel(userData: UserData(), userStorage: UserStorage(), defineProgress: true)
        
        var body: some View {
            VStack {
                DefineLook(selected: $defineUserViewModel.wantLook, defineCount: $defineUserViewModel.defineCount)
            }
        }
    }
}
