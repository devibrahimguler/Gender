//
//  LookSelectButton.swift
//  Gender
//
//  Created by İbrahim Güler on 29.07.2023.
//

import SwiftUI

struct LookSelectButton: View {
    
    @Binding var selected : String
    var header : String
    var text : String
    
    init(selected: Binding<String>, header: String, text: String) {
        self._selected = selected
        self.header = header
        self.text = text
    }
    
    var body: some View {
        VStack {
            Button {
                self.selected = self.text
            } label: {
                RoundedRectangle(cornerRadius: 25)
                    .fill( self.selected == self.text ? .blue : .gray)
                    .overlay {
                        VStack {
                            Text(header)
                                .font(.title)
                            
                            Text(self.text)
                                .font(.title)
                        }
                        .foregroundColor(.black)
                    }
            }
        }
    }
}
