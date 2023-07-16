//
//  BirtDaySelection.swift
//  Gender
//
//  Created by İbrahim Güler on 16.07.2023.
//

import SwiftUI
import Combine

struct BirtDaySelection: View {
    
    @Binding var text : String
    var placeHolder: String
    var isMounth1: Bool
    
    init(text: Binding<String>, placeHolder: String, isMounth1: Bool = false) {
        _text = text
        self.placeHolder = placeHolder
        self.isMounth1 = isMounth1
    }
    
    var body: some View {
        VStack(alignment: .center) {
            TextField(placeHolder.uppercased(), text: $text)
                .keyboardType(.decimalPad)
                .fixedSize(horizontal: true, vertical: false)
                .limitText($text, to: 1)
                .onReceive(Just(text)) { newValue in
                    var allowedCharacters = ""
                    if isMounth1 {
                        allowedCharacters = "01"
                    } else {
                        allowedCharacters = "0123456789"
                    }
                    
                    let filtered = newValue.filter { allowedCharacters.contains($0) }
                    if filtered != newValue {
                        self.text = filtered
                    }
                }
             
            
            Divider()
        }
    }
}

struct BirtDaySelection_Previews: PreviewProvider {
    @State static var text = ""
    static var previews: some View {
        BirtDaySelection(text: $text, placeHolder: "D")
    }
}

extension View {
    func limitText(_ text: Binding<String>, to characterLimit: Int) -> some View {
        self
            .onChange(of: text.wrappedValue) { a in
                text.wrappedValue = String(text.wrappedValue.prefix(characterLimit))
            }
    }
}
