//
//  DefineBirthDay.swift
//  Gender
//
//  Created by İbrahim Güler on 16.07.2023.
//

import SwiftUI

struct DefineBirthDay: View {
    
    @Binding var birthList : [String]
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
            
            Text("Your birth date?")
                .font(.system(size: 40, weight: .bold))
            
            HStack(spacing: 10) {
                
                Spacer()
                HStack(spacing: 10) {
                    BirtDaySelection(text: $birthList[0], placeHolder: "D")
                    BirtDaySelection(text: $birthList[1], placeHolder: "D")
                    
                }
                
                Text("\(birthList[2])")
                
                HStack(spacing: 10) {
                    BirtDaySelection(text: $birthList[3], placeHolder: "M", isMounth1: true)
                    BirtDaySelection(text: $birthList[4], placeHolder: "M")
                    
                }
                
                Text("\(birthList[5])")
                
                HStack(spacing: 10) {
                    
                    BirtDaySelection(text:  $birthList[6], placeHolder: "Y")
                    BirtDaySelection(text:  $birthList[7], placeHolder: "Y")
                    BirtDaySelection(text:  $birthList[8], placeHolder: "Y")
                    BirtDaySelection(text:  $birthList[9], placeHolder: "Y")
                }
                
                Spacer()
                
            }
            .font(.title)
            
            
            Text("Profilinde yaşın gösterilir, doğum tarihin değil.")
                .font(.callout)
                .padding(.top)
            
            Spacer(minLength: 10)
            
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

struct DefineBirthDay_Previews: PreviewProvider {
    static var previews: some View {
        TestDefineBirthDay()
    }
    
    struct TestDefineBirthDay : View {
        @ObservedObject var defineUserViewModel : DefineUserViewModel = DefineUserViewModel()
        
        var body: some View {
            VStack {
                DefineBirthDay(birthList: $defineUserViewModel.defineBirthDay, defineCount: $defineUserViewModel.defineCount)
            }
        }
    }
}


