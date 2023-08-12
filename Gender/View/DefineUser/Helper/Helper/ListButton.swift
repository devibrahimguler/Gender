//
//  ListButton.swift
//  Gender
//
//  Created by İbrahim Güler on 29.07.2023.
//

import SwiftUI

struct ListButton: View {
    
    var isHobies : Bool
    var text : String
    @Binding var list : [String]
    
    init( isHobies : Bool = false, text: String, list: Binding<[String]>) {
        self.isHobies = isHobies
        self.text = text
        _list = list
    }
    
    var body: some View {
        VStack {
            Button {
                if self.list.contains(text)  {
                    if self.list.count > 0 {
                        if let index = self.list.firstIndex(of: text) {
                            self.list.remove(at: index)
                        }
                    }
                } else {
                    if self.list.count < 5 {
                        self.list.append(text)
                        
                    }
                }
            
            } label: {
                Text(self.text)
                    .font(.body)
                    .foregroundColor(list.contains(text) ? .blue : .gray)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                    .overlay {
                        if isHobies {
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(lineWidth: 1)
                                .fill(list.contains(text) ? .blue : .gray)
                        }
                
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    
    }
}

struct ListButton_Previews: PreviewProvider {
    
    @State static var list : [String] = ["selected1"]
    
    static var previews: some View {
        ListButton(text: "selected1", list: $list)
    }
}
