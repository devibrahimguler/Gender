//
//  BirthDayAtDay.swift
//  Gender
//
//  Created by İbrahim Güler on 29.07.2023.
//

import SwiftUI

struct BirtDayAtDay: View {
    
    @Binding var day1 : String
    @Binding var day2 : String
    
    init(day1:  Binding<String>, day2:  Binding<String>) {
        self._day1 = day1
        self._day2 = day2
    }
    
    var body: some View {
        HStack {
            
            BirtDaySelection(text: $day1, placeHolder: "D")
            BirtDaySelection(text: $day2, placeHolder: "D")
        }
    }
}

struct BirtDayAtDay_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
