//
//  SlipText.swift
//  Gender
//
//  Created by İbrahim Güler on 4.09.2023.
//

import SwiftUI

struct SlipText: View {
    
    var text : String
    var color : Color
    var isLike : Bool
    
    var body: some View {
        Text(text)
            .font(.system(size: 40))
            .bold()
            .padding(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 3)
                
            }
            .foregroundColor(color)
            .opacity(0.6)
            .rotationEffect(Angle(degrees: isLike ? -10 : 10))
            .offset(x:  isLike ? -100 : 100, y: -200)
    }
}

struct SlipText_Previews: PreviewProvider {
    static var previews: some View {
        SlipText(text: " LİKE ", color: .blue, isLike: true)
    }
}
