//
//  DefineOrientation.swift
//  Gender
//
//  Created by İbrahim Güler on 16.07.2023.
//

import SwiftUI

struct DefineOrientation: View {
    @EnvironmentObject var homeViewModel : HomeViewModel
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Button {
                    homeViewModel.defineCount -= 1
                } label: {
                    Image(systemName: "chevron.backward")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)
                }
                
                Spacer(minLength: 10)
                
                Button {
                    homeViewModel.defineCount -= 1
                } label: {
                    Text("Skip")
                        .font(.system(size: 30))
                        .foregroundColor(.gray)
                }
            }
            .padding(.bottom, 20)

            Text("Your sexual orientation?")
                .font(.system(size: 40, weight: .bold))
                .padding(.bottom, 10)
            
            Text("You can choose up to 3.")
                .font(.callout)
                .foregroundColor(.gray)
                .padding(.bottom, 10)
            
            VStack(spacing: 10) {
                Button {
                    homeViewModel.defineCount += 1
                } label: {
                    Text("Heterosexual")
                        .font(.title3)
                        .foregroundColor(.black)
                }
                
                Button {
                    homeViewModel.defineCount += 1
                } label: {
                    Text("Heterosexual")
                        .font(.title3)
                        .foregroundColor(.black)
                }
                
                Button {
                    homeViewModel.defineCount += 1
                } label: {
                    Text("Heterosexual")
                        .font(.title3)
                        .foregroundColor(.black)
                }
                
                Button {
                    homeViewModel.defineCount += 1
                } label: {
                    Text("Heterosexual")
                        .font(.title3)
                        .foregroundColor(.black)
                }
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
                    
                    Text("Profilimde yönelimimi göster")
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

struct DefineOrientation_Previews: PreviewProvider {
    static var previews: some View {
        DefineOrientation()
            .environmentObject({ () -> HomeViewModel in return HomeViewModel() }() )
    }
}
