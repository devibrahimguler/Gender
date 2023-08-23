//
//  DefineDistance.swift
//  Gender
//
//  Created by İbrahim Güler on 16.07.2023.
//

import SwiftUI

struct DefineDistance: View {
    
    @Binding var position : CGPoint
    @Binding var defineCount : Int
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Button {
                defineCount -= 1
            } label: {
                Image(systemName: "chevron.backward")
                    .font(.system(size: 50))
                    .foregroundColor(.gray)
            }
            .padding(.bottom)
            
            Text("What is your distance preference?")
                .font(.system(size: 40, weight: .bold))
                .padding(.bottom)
            
            Text("Use the slider to set the maximum distance you want potential matches to be found.")
                .font(.callout)
            
            Divider()
            
            VStack {
                HStack {
                    Text("Distance Preference")
                        .font(.callout)
                    
                    Spacer(minLength: 10)
                    
                    Text("\(position.x) km")
                        .font(.callout)
                }
                
                ZStack{
                    HStack(spacing: 0) {
                        Rectangle()
                            .fill(.red)
                            .frame(width: position.x, height: 5)
                        
                        Rectangle()
                            .fill(.gray)
                            .frame(height: 5)
                        
                    }
                    
                    Circle()
                        .stroke(lineWidth: 2)
                        .overlay {
                            Circle()
                                .fill(.white)
                        }
                        .position(x: position.x + 20, y: 25)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    if value.location.x >= 0 && value.location.x <= 320 {
                                        position.x = value.location.x
                                    }
                                   
                                    
                                }
                            
                        )
                    
                }
                .frame(height: 50)
            }
            
            Divider()
            
            
            
            Spacer(minLength: 10)
            
            Button {
                defineCount += 1
            } label: {
                Text("Go On!")
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(.red)
                    .bold()
                    .foregroundColor(.white)
                    .cornerRadius(50)
                
            }
            
        }
        .padding(20)
    }
}

struct DefineDistance_Previews: PreviewProvider {
    static var previews: some View {
        TestDefineDistance()
    }
    
    struct TestDefineDistance : View {
        @ObservedObject var defineUserViewModel : DefineUserViewModel = DefineUserViewModel()
        
        var body: some View {
            VStack {
                DefineDistance(position: $defineUserViewModel.position, defineCount: $defineUserViewModel.defineCount)
            }
        }
    }
}
