//
//  GenderProgress.swift
//  Gender
//
//  Created by İbrahim Güler on 1.07.2023.
//

import SwiftUI

struct GenderProgress: View {
    
    @State var rotation = 30.0
    var startColor : Color = Color("Start")
    var endColor : Color = Color("End")
    
    var body: some View {
        
        VStack{
            
            Text("Gender")
                .foregroundColor(.white)
                .font(.system(size: 40,weight: .bold, design: .rounded))
                .rotationEffect(Angle(degrees: rotation))
                .animation(.easeOut.repeatForever(), value: rotation)
            
        }.onAppear {
            rotation = rotation == 30 ? rotation - 60 : rotation + 60
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(colors: [startColor, endColor], startPoint: .leading, endPoint: .trailing))
        
    }
}

struct GenderProgress_Previews: PreviewProvider {
    static var previews: some View {
        TestGenderProgress()
    }
    
    struct TestGenderProgress : View {
        
        var body: some View {
            VStack {
                GenderProgress()
                
            }
        }
    }
}
