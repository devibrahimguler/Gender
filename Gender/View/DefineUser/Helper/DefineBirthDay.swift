//
//  DefineBirthDay.swift
//  Gender
//
//  Created by İbrahim Güler on 16.07.2023.
//

import SwiftUI

struct DefineBirthDay: View {
    
    @Binding var list : [String]
    @Binding var count : Int
    @State var complation : Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Button {
                count -= 1
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
                    BirtDaySelection(text: $list[0], placeHolder: "D")
                    BirtDaySelection(text: $list[1], placeHolder: "D")
                    
                }
                
                Text("\(list[2])")
                
                HStack(spacing: 10) {
                    BirtDaySelection(text: $list[3], placeHolder: "M", isMounth1: true)
                    BirtDaySelection(text: $list[4], placeHolder: "M")
                    
                }
                
                Text("\(list[5])")
                
                HStack(spacing: 10) {
                    
                    BirtDaySelection(text:  $list[6], placeHolder: "Y")
                    BirtDaySelection(text:  $list[7], placeHolder: "Y")
                    BirtDaySelection(text:  $list[8], placeHolder: "Y")
                    BirtDaySelection(text:  $list[9], placeHolder: "Y")
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
                    count += 1
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
        .onChange(of: list) { _ in
            complation = ControlBirthDay()
        }
    }
    
    func ControlBirthDay() -> Bool {
        for i in list {
            if i == "" {
                return false
            }
            
            if let mounth1 = Int(list[3]) {
                if let mounth2 = Int(list[4]) {
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
        @ObservedObject var defineUserViewModel : DefineUserViewModel = DefineUserViewModel(userData: UserData(), userStorage: UserStorage(), defineProgress: true)
        
        var body: some View {
            VStack {
                DefineBirthDay(list: $defineUserViewModel.defineBirthDay, count: $defineUserViewModel.defineCount)
            }
        }
    }
}


