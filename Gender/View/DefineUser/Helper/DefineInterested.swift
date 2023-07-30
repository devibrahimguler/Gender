//
//  DefineInterested.swift
//  Gender
//
//  Created by İbrahim Güler on 16.07.2023.
//

import SwiftUI

struct DefineInterested: View {
    
    @EnvironmentObject var defineUserViewModel : DefineUserViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Button {
                defineUserViewModel.defineCount -= 1
            } label: {
                Image(systemName: "chevron.backward")
                    .font(.system(size: 50))
                    .foregroundColor(.gray)
            }
            .padding(.bottom)

            Text("Who are you interested in seeing?")
                .font(.system(size: 40, weight: .bold))
            
            Button {
                defineUserViewModel.selectedInterested = "Female"
            } label: {
                RoundedRectangle(cornerRadius: 50)
                    .stroke(lineWidth: 2)
                    .overlay {
                        Text("Female")
                            .font(.largeTitle)
                            .bold()
                    }
                    .frame(height: 60)
                    .foregroundColor(defineUserViewModel.selectedInterested == "Female" ? .red : .gray)
            }
            
            Button {
                defineUserViewModel.selectedInterested = "Male"
            } label: {
                
                RoundedRectangle(cornerRadius: 50)
                    .stroke(lineWidth: 2)
                    .overlay {
                        Text("Male")
                            .font(.largeTitle)
                            .bold()
                    }
                    .frame(height: 60)
                    .foregroundColor(defineUserViewModel.selectedInterested == "Male" ? .blue : .gray)
            }
            
            Button {
                defineUserViewModel.selectedInterested = "Everyone"
            } label: {
                
                RoundedRectangle(cornerRadius: 50)
                    .stroke(lineWidth: 2)
                    .overlay {
                        Text("Everyone")
                            .font(.largeTitle)
                            .bold()
                    }
                    .frame(height: 60)
                    .foregroundColor(defineUserViewModel.selectedInterested == "Everyone" ? .purple : .gray)
            }
            
            Spacer(minLength: 10)
            
            Button {
                defineUserViewModel.defineCount += 1
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
            .environmentObject({ () -> DefineUserViewModel in return DefineUserViewModel() }() )
    }
}
