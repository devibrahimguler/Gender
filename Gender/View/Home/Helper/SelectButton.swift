//
//  SelectButton.swift
//  Gender
//
//  Created by İbrahim Güler on 4.09.2023.
//

import SwiftUI

struct SelectButton: View {
    
    var sense : SenseButtonType
    var complation : () -> ()
    
    init(sense: SenseButtonType, complation: @escaping () -> Void) {
        self.sense = sense
        self.complation = complation
    }
    
    var body: some View {
        Button {
            complation()
        } label: {
            Circle()
                .stroke(lineWidth: 4)
                .frame(width: 65, height: 65)
                .overlay {
                    Image(systemName: sense.rawValue)
                        .resizable()
                        .bold()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
              
                }
                .foregroundColor(Color("\(sense)"))
                .shadow(color: .black, radius: 3)
          
        }
    }
}

struct SelectButton_Previews: PreviewProvider {
    static var previews: some View {
        SelectButton(sense: .Like) {
            
        }
    }
}
