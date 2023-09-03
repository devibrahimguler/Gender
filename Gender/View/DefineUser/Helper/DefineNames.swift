//
//  DefineNames.swift
//  Gender
//
//  Created by İbrahim Güler on 8.07.2023.
//

import SwiftUI

struct DefineNames: View {
    
    @Binding var name : String
    @Binding var defineCount : Int
    
    var notEmptyName : Bool {
        return name == ""
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Button {
                
            } label: {
                Image(systemName: "multiply")
                    .font(.system(size: 50))
                    .foregroundColor(.gray)
            }
            .padding(.bottom)

            Text("What is your name?")
                .font(.system(size: 40, weight: .bold))
            
            TextField("enter your name".uppercased(), text: $name)
                .keyboardType(.namePhonePad)
                .textInputAutocapitalization(.never)
                .font(.headline.weight(.bold))
            
            Divider()
            
            Text("Profilinde bu sekilde görünecek.")
                .font(.callout)
        
            Text("Bunu daha sonra degistiremezsin.")
                .font(.callout.bold())

            Spacer(minLength: 10)
            
            Button {
                defineCount += 1
            } label: {
                Text("Go On!")
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(notEmptyName ? .gray : .red)
                    .bold()
                    .foregroundColor(.white)
                    .cornerRadius(50)
             
            }
            .disabled(notEmptyName)
      
        }
        .padding(20)
    }
}

struct DefineNames_Previews: PreviewProvider {
    static var previews: some View {
        TestDefineNames()
    }
    
    struct TestDefineNames : View {
        @ObservedObject var defineUserViewModel : DefineUserViewModel = DefineUserViewModel(userData: UserData(), userStorage: UserStorage(), defineProgress: true)
        
        var body: some View {
            VStack {
                DefineNames(name: $defineUserViewModel.name, defineCount: $defineUserViewModel.defineCount)
            }
        }
    }
}
