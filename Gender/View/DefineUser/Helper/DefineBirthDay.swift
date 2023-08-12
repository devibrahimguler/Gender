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
                    .foregroundColor(.gray)
            }
            .padding(.bottom)

            Text("Your birth date?")
                .font(.system(size: 40, weight: .bold))
            
            HStack(spacing: 10) {
                
                Spacer()
                
                BirtDayAtDay(day1: $homeViewModel.defineBirthDayD1, day2: $homeViewModel.defineBirthDayD2)
                
                Text("/")
                
                
                BirtDayAtMonth(month1: $homeViewModel.defineBirthDayM1, month2: $homeViewModel.defineBirthDayM2)
                
                Text("/")
               
                
                BirtDayAtYear(year1: $homeViewModel.defineBirthDayY1, year2: $homeViewModel.defineBirthDayY2, year3: $homeViewModel.defineBirthDayY3, year4: $homeViewModel.defineBirthDayY4)
                
                Spacer()
                
            }
            .font(.title)
    
            
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


