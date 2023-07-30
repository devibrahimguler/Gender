//
//  BirthDayAtMonth.swift
//  Gender
//
//  Created by İbrahim Güler on 29.07.2023.
//

import SwiftUI

struct BirtDayAtMonth: View {
    
    @Binding var month1 : String
    @Binding var month2 : String
    
    init(month1:  Binding<String>, month2:  Binding<String>) {
        self._month1 = month1
        self._month2 = month2
    }
    
    var body: some View {
        HStack {
            
            BirtDaySelection(text: $month1, placeHolder: "M", isMounth1: true)
            BirtDaySelection(text: $month2, placeHolder: "M")
            
        }
    }
}

struct BirtDayAtMonth_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
