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
    @State var complation : Bool = false
    
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
                if complation {
                    defineCount += 1
                }
            } label: {
                Text("Go On!")
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(complation ? .red : .gray)
                    .bold()
                    .foregroundColor(.white)
                    .cornerRadius(50)
                
            }
            .disabled(!complation)
       
            
        }
        .padding(20)
        .onChange(of: birthList) { _ in
            complation = ControlBirthDay()
        }
    }
    
    func ControlBirthDay() -> Bool {
        for i in birthList {
            if i == "" {
                return false
            }
            
            if let mounth1 = Int(birthList[3]) {
                if let mounth2 = Int(birthList[4]) {
                    if mounth1 >= 1 && mounth2 >= 3 {
                         return false
                    }
                }
            }
        }
        
        return true
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


