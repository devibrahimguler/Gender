//
//  DefineGender.swift
//  Gender
//
//  Created by İbrahim Güler on 16.07.2023.
//

import SwiftUI

struct DefineGender: View {
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

            Text("What is your gender?")
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
            
            Spacer(minLength: 10)
            
            Divider()
            
            Button {
                homeViewModel.defineCount -= 1
            } label: {
                
                HStack {
                    if true {
                        Image(systemName: "checkmark.square")
                    } else {
                        // Image(systemName: "square")
                    }
                    
                    Text("Profilimde cinsiyetimi göster")
                        .font(.headline)
                }
                .foregroundColor(.gray)
     
                
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.vertical)
            
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

struct DefineGender_Previews: PreviewProvider {
    static var previews: some View {
        DefineGender()
            .environmentObject({ () -> HomeViewModel in return HomeViewModel() }() )
    }
}
