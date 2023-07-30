//
//  BirthDayAtYear.swift
//  Gender
//
//  Created by İbrahim Güler on 29.07.2023.
//

import SwiftUI

struct BirtDayAtYear: View {
    
    @Binding var year1 : String
    @Binding var year2 : String
    @Binding var year3 : String
    @Binding var year4 : String
    
    init(year1:  Binding<String>, year2:  Binding<String>, year3:  Binding<String>, year4:  Binding<String>) {
        self._year1 = year1
        self._year2 = year2
        self._year3 = year3
        self._year4 = year4
    }
    var body: some View {
        HStack {
            
            BirtDaySelection(text: $year1, placeHolder: "Y")
            BirtDaySelection(text: $year2, placeHolder: "Y")
            BirtDaySelection(text: $year3, placeHolder: "Y")
            BirtDaySelection(text: $year4, placeHolder: "Y")
        }
    }
}

struct BirtDayAtYear_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
