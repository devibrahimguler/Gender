//
//  LookSelectButton.swift
//  Gender
//
//  Created by İbrahim Güler on 29.07.2023.
//

import SwiftUI

struct LookSelectButton: View {
    
    @EnvironmentObject var homeViewModel : HomeViewModel
    var header : String
    var text : String
    
    var body: some View {
        VStack {
            Button {
                homeViewModel.selectedLook = self.text
            } label: {
                RoundedRectangle(cornerRadius: 25)
                    .fill( homeViewModel.selectedLook == self.text ? .blue : .gray)
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

struct LookSelectButton_Previews: PreviewProvider {
    static var previews: some View {
        LookSelectButton(header: "", text: "")
            .environmentObject({ () -> HomeViewModel in return HomeViewModel() }() )
    }
}
