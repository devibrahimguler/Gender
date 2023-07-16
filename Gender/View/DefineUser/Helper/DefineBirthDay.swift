//
//  DefineBirthDay.swift
//  Gender
//
//  Created by İbrahim Güler on 16.07.2023.
//

import SwiftUI

struct DefineBirthDay: View {
    
    @EnvironmentObject var homeViewModel : HomeViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Button {
                homeViewModel.defineCount -= 1
            } label: {
                Image(systemName: "chevron.backward")
                    .font(.system(size: 50))
                    .padding(.bottom)
                    .foregroundColor(.gray)
            }

            Text("Your birth date?")
                .font(.system(size: 40, weight: .bold))
            
            HStack(spacing: 10) {
                
                BirtDaySelection(text: $homeViewModel.defineBirthDayD1, placeHolder: "D")
                BirtDaySelection(text: $homeViewModel.defineBirthDayD2, placeHolder: "D")
                
                Text("/")
                    .font(.callout)
                
                BirtDaySelection(text: $homeViewModel.defineBirthDayM1, placeHolder: "M", isMounth1: true)
                BirtDaySelection(text: $homeViewModel.defineBirthDayM2, placeHolder: "M")
                
                Text("/")
                    .font(.callout)
                
                BirtDaySelection(text: $homeViewModel.defineBirthDayY1, placeHolder: "Y")
                BirtDaySelection(text: $homeViewModel.defineBirthDayY2, placeHolder: "Y")
                BirtDaySelection(text: $homeViewModel.defineBirthDayY3, placeHolder: "Y")
                BirtDaySelection(text: $homeViewModel.defineBirthDayY4, placeHolder: "Y")
                
            }
    
            
            Text("Profilinde yaşın gösterilir, doğum tarihin değil.")
                .font(.callout)
                .padding(.top)

            Spacer(minLength: 10)
            
            Button {
                homeViewModel.defineCount += 1
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

struct DefineBirthDay_Previews: PreviewProvider {
    static var previews: some View {
        DefineBirthDay()
            .environmentObject({ () -> HomeViewModel in return HomeViewModel() }() )
    }
}


