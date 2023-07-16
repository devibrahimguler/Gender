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
                    .padding(.bottom, 20)
                    .foregroundColor(.gray)
            }

            Text("Who are you interested in seeing?")
                .font(.system(size: 40, weight: .bold))
            
            Button {
                homeViewModel.defineCount += 1
            } label: {
                RoundedRectangle(cornerRadius: 50)
                    .stroke(lineWidth: 2)
                    .overlay {
                        Text("Female")
                            .font(.largeTitle)
                    }
                    .frame(height: 60)
                    .foregroundColor(.gray)
            }
            
            Button {
                homeViewModel.defineCount += 1
            } label: {
                
                RoundedRectangle(cornerRadius: 50)
                    .stroke(lineWidth: 2)
                    .overlay {
                        Text("Male")
                            .font(.largeTitle)
                    }
                    .frame(height: 60)
                    .foregroundColor(.gray)
            }
            
            Button {
                homeViewModel.defineCount += 1
            } label: {
                
                RoundedRectangle(cornerRadius: 50)
                    .stroke(lineWidth: 2)
                    .overlay {
                        Text("Everyone")
                            .font(.largeTitle)
                    }
                    .frame(height: 60)
                    .foregroundColor(.gray)
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
