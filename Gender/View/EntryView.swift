//
//  EntryView.swift
//  Gender
//
//  Created by İbrahim Güler on 1.07.2023.
//

import SwiftUI

struct EntryView: View {
    
    @ObservedObject var entryViewModel : EntryViewModel
    
    var startColor : Color
    var endColor : Color
    
    init(userConnection : AuthProtocol, entryProgress: Binding<Bool>, isConnected: Binding<Bool>, startColor: Color, endColor: Color) {
        self.entryViewModel = EntryViewModel(userConnection: userConnection, entryProgress: entryProgress, isConnected: isConnected)
        self.startColor = startColor
        self.endColor = endColor
    }
    
    var body: some View {
        ZStack {
            Login(startColor: startColor, endColor: endColor, email: $entryViewModel.email, password: $entryViewModel.password, isFocused: $entryViewModel.isFocused, isLogin: $entryViewModel.isLogin)
            {
                entryViewModel.loginUser()
            }
            .offset(x:entryViewModel.isLogin ? 0 : getRect().width * 2)
            
            Register(startColor: startColor, endColor: endColor, email: $entryViewModel.email, password: $entryViewModel.password, isFocused: $entryViewModel.isFocused, isLogin: $entryViewModel.isLogin)
            {
                entryViewModel.registerUser()
            }
                .offset(x:entryViewModel.isLogin ? -getRect().width * 2 : 0)
               
            
        }
        .animation(.easeInOut, value: entryViewModel.isLogin)
        .background(LinearGradient(colors: [startColor, endColor], startPoint: .leading, endPoint: .trailing))
    }
}

struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        TestEntryView()
    }
    struct TestEntryView : View {
        
        @StateObject var homeViewModel : HomeViewModel = HomeViewModel()
        
        var startColor : Color = Color("Start")
        var endColor : Color = Color("End")
        
        var body: some View {
            VStack {
                EntryView(userConnection : homeViewModel.userConnection, entryProgress: $homeViewModel.isProgress, isConnected: $homeViewModel.isConnected, startColor: startColor, endColor: endColor)
            }
        }
    }
}

extension View {
    func getRect() -> CGSize {
        return UIScreen.main.bounds.size
    }
}
