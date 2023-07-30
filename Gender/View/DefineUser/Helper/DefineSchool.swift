//
//  DefineSchool.swift
//  Gender
//
//  Created by İbrahim Güler on 16.07.2023.
//

import SwiftUI

struct DefineSchool: View {
    
    @EnvironmentObject var defineUserViewModel : DefineUserViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Button {
                    defineUserViewModel.defineCount -= 1
                } label: {
                    Image(systemName: "chevron.backward")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)
                }
                
                Spacer(minLength: 10)
                
                Button {
                    defineUserViewModel.defineCount += 1
                } label: {
                    Text("Skip")
                        .font(.system(size: 30))
                        .foregroundColor(.gray)
                }
            }
            .padding(.bottom)

            Text("If you want to write your school...")
                .font(.system(size: 40, weight: .bold))
            
            TextField("Enter the name of your school".uppercased(), text: $defineUserViewModel.selectedSchool)
                .keyboardType(.namePhonePad)
                .textInputAutocapitalization(.never)
                .font(.headline.weight(.bold))
            
            Divider()
            
            Text("Profilinde bu sekilde görünecek.")
                .font(.callout)

            Spacer(minLength: 10)
            
            Button {
                if defineUserViewModel.selectedSchool != "" {
                    defineUserViewModel.defineCount += 1
                }
          
            } label: {
                Text("Go On!")
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(defineUserViewModel.selectedSchool == "" ? .gray : .red)
                    .bold()
                    .foregroundColor(.white)
                    .cornerRadius(50)
             
            }
            .disabled(defineUserViewModel.selectedSchool == "")
      
        }
        .padding(20)
    }
}

struct DefineSchool_Previews: PreviewProvider {
    static var previews: some View {
        DefineSchool()
            .environmentObject({ () -> DefineUserViewModel in return DefineUserViewModel() }() )
    }
}
