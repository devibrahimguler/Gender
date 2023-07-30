//
//  DefineLook.swift
//  Gender
//
//  Created by İbrahim Güler on 16.07.2023.
//

import SwiftUI

struct DefineLook: View {
    
    @EnvironmentObject var defineUserViewModel : DefineUserViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Button {
                defineUserViewModel.defineCount -= 1
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
                
                LookSelectButton(header: "💖", text: "USİ")
      
                LookSelectButton(header: "😍", text: "UİKO")
            
                LookSelectButton(header: "🥂", text: "KİUO")
                
            }
            .frame(height: 150)
            
            Spacer(minLength: 10)
            
            Button {
                defineUserViewModel.defineCount += 1
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
            .environmentObject({ () -> DefineUserViewModel in return DefineUserViewModel() }() )
    }
}
