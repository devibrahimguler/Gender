//
//  Home.swift
//  Gender
//
//  Created by İbrahim Güler on 2.07.2023.
//

import SwiftUI

struct Home: View {
    
    @EnvironmentObject var mainViewModel : MainViewModel
    
    var startColor : Color
    var endColor : Color
    
    var body: some View {
        VStack {
            
            
            HStack {
                Button {
                    mainViewModel.isProfile.toggle()
                } label: {
                    RoundedRectangle(cornerRadius: 7)
                        .fill(LinearGradient(colors: [startColor, endColor], startPoint: .leading, endPoint: .trailing))
                        .frame(width: 40, height: 40)
                        .overlay {
                            Image(systemName: mainViewModel.isProfile ? "multiply": "line.3.horizontal")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                        }
                    
                    
                }
                
                Spacer()
                
                Text("Gender")
                    .foregroundColor(endColor)
                    .font(.title.bold())
                
                Spacer()
           
            }
            
            Spacer()
            
            PhotoSelection()
                .environmentObject(mainViewModel)
            
            Spacer()
            
     
            
        }

        .padding(mainViewModel.isProfile ? 30 : 10)
        .background(Color.white.cornerRadius(mainViewModel.isProfile ? 50 : .zero).edgesIgnoringSafeArea(.all))
        .onTapGesture {
            mainViewModel.isProfile = false
        }
        .frame(width:  mainViewModel.isProfile ? getRect().width : nil,  height:  mainViewModel.isProfile ? getRect().height / 1.2 : nil)

        .offset(x: mainViewModel.isProfile ? getRect().width / 2 : 0)
        .animation(.spring().delay(0.1), value: mainViewModel.isProfile)
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        TestHome()
    }
    
    struct TestHome : View {
        @StateObject var mainViewModel : MainViewModel = MainViewModel()
        
        var startColor : Color = Color("Start")
        var endColor : Color = Color("End")
        
        var body: some View {
            VStack {
                Home(startColor: startColor, endColor: endColor)
                    .environmentObject(mainViewModel)
            }
        }
    }
}
