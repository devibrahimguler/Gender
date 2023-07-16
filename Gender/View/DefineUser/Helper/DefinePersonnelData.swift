//
//  DefinePersonnelData.swift
//  Gender
//
//  Created by İbrahim Güler on 4.07.2023.
//

import SwiftUI

struct DefinePersonnelData: View {
    
    @EnvironmentObject var homeViewModel : HomeViewModel
    
    var body: some View {
        VStack {
            VStack {
                Text("Name")
                    .font(.custom("AmericanTypewriter", fixedSize: 36).weight(.bold))
                    .background(.gray)
                    .foregroundColor(.white)
            }
            .padding(.top, 20)
            .padding(.bottom, 5)
            .padding(.leading, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.gray)
            
            VStack {
                TextField("Your Name".uppercased(), text: $homeViewModel.name)
                    .keyboardType(.namePhonePad)
                    .textInputAutocapitalization(.never)
                    .font(.headline.weight(.bold))
            }
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.white)
            
            VStack {
                Text("Surname")
                    .font(.custom("AmericanTypewriter", fixedSize: 36).weight(.bold))
                    .background(.gray)
                    .foregroundColor(.white)
            }
            .padding(.top, 20)
            .padding(.bottom, 5)
            .padding(.leading, 10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.gray)
            
            VStack {
                TextField("Your Surname".uppercased(), text: $homeViewModel.surname)
                    .keyboardType(.namePhonePad)
                    .textInputAutocapitalization(.never)
                    .font(.headline.weight(.bold))

            }
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.white)
            

            HStack {
                Spacer()
                
                Button {
                    homeViewModel.defineCount += 1
                } label: {
                    Text("Submit")
                }

            }
            .padding(20)
        }
    }
}

struct DefinePersonnelData_Previews: PreviewProvider {
    static var previews: some View {
        DefinePersonnelData()
    }
}
