//
//  DefineInterested.swift
//  Gender
//
//  Created by İbrahim Güler on 16.07.2023.
//

import SwiftUI

struct DefineInterested: View {
    
    @EnvironmentObject var homeViewModel : HomeViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Button {
                homeViewModel.defineCount -= 1
            } label: {
                Image(systemName: "chevron.backward")
                    .font(.system(size: 50))
                    .foregroundColor(.gray)
            }
            .padding(.bottom)

            Text("Who are you interested in seeing?")
                .font(.system(size: 40, weight: .bold))
            
            Button {
                homeViewModel.selectedInterested = "Female"
            } label: {
                RoundedRectangle(cornerRadius: 50)
                    .stroke(lineWidth: 2)
                    .overlay {
                        Text("Female")
                            .font(.largeTitle)
                            .bold()
                    }
                    .frame(height: 60)
                    .foregroundColor(homeViewModel.selectedInterested == "Female" ? .red : .gray)
            }
            
            Button {
                homeViewModel.selectedInterested = "Male"
            } label: {
                
                RoundedRectangle(cornerRadius: 50)
                    .stroke(lineWidth: 2)
                    .overlay {
                        Text("Male")
                            .font(.largeTitle)
                            .bold()
                    }
                    .frame(height: 60)
                    .foregroundColor(homeViewModel.selectedInterested == "Male" ? .blue : .gray)
            }
            
            Button {
                homeViewModel.selectedInterested = "Everyone"
            } label: {
                
                RoundedRectangle(cornerRadius: 50)
                    .stroke(lineWidth: 2)
                    .overlay {
                        Text("Everyone")
                            .font(.largeTitle)
                            .bold()
                    }
                    .frame(height: 60)
                    .foregroundColor(homeViewModel.selectedInterested == "Everyone" ? .purple : .gray)
            }
            
            Spacer(minLength: 10)
            
            Button {
                homeViewModel.defineCount += 1
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

struct DefineInterested_Previews: PreviewProvider {
    static var previews: some View {
        DefineInterested()
            .environmentObject({ () -> HomeViewModel in return HomeViewModel() }() )
    }
}
