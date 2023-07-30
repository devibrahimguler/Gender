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
    @Binding var tag : Int
    
    init( isHobies : Bool = false, text: String, list: Binding<[String]>, tag: Binding<Int>) {
        self.isHobies = isHobies
        self.text = text
        _list = list
        _tag = tag
    }
    
    var body: some View {
        VStack {
            Button {
                if self.list.contains(text)  {
                    if self.tag > 0 {
                        self.tag -= 1
                        if let index = self.list.firstIndex(of: text) {
                            self.list.remove(at: index)
                        }
                    }
                } else {
                    if self.tag < 5 {
                        self.tag += 1
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
            }
        }
    }
}

struct ListButton_Previews: PreviewProvider {
    
    @State static var list : [String] = [""]
    @State static var tag : Int = 0
    
    static var previews: some View {
        ListButton(text: "", list: $list, tag: $tag)
    }
}
