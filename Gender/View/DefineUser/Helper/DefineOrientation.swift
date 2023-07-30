//
//  DefineOrientation.swift
//  Gender
//
//  Created by İbrahim Güler on 16.07.2023.
//

import SwiftUI

struct DefineOrientation: View {

    @EnvironmentObject var defineUserViewModel : DefineUserViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Button {
                    defineUserViewModel.defineCount -= 1
                } label: {
                    Image(systemName: "chevron.backward")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)
                }
                
                Spacer(minLength: 10)
                
                Button {
                    defineUserViewModel.defineCount += 1
                } label: {
                    Text("Skip")
                        .font(.system(size: 30))
                        .foregroundColor(.gray)
                }
            }
            .padding(.bottom)

            Text("Your sexual orientation?")
                .font(.system(size: 40, weight: .bold))
                .padding(.bottom, 10)
            
            Text("You can choose up to 5.")
                .font(.callout)
                .foregroundColor(.gray)
                .padding(.bottom, 10)
            
            VStack(spacing: 10) {
                
                ListButton(text: "Heterosexual", list: $defineUserViewModel.selectedOrientation, tag: $defineUserViewModel.selectedTagsOrientation)
                
                ListButton(text: "Heterosexual1", list: $defineUserViewModel.selectedOrientation, tag: $defineUserViewModel.selectedTagsOrientation)
                
                ListButton(text: "Heterosexual2", list: $defineUserViewModel.selectedOrientation, tag: $defineUserViewModel.selectedTagsOrientation)
                
                ListButton(text: "Heterosexual3", list: $defineUserViewModel.selectedOrientation, tag: $defineUserViewModel.selectedTagsOrientation)
                
                ListButton(text: "Heterosexual4", list: $defineUserViewModel.selectedOrientation, tag: $defineUserViewModel.selectedTagsOrientation)
                
                ListButton(text: "Heterosexual5", list: $defineUserViewModel.selectedOrientation, tag: $defineUserViewModel.selectedTagsOrientation)
                
                ListButton(text: "Heterosexual6", list: $defineUserViewModel.selectedOrientation, tag: $defineUserViewModel.selectedTagsOrientation)
            }
            
          
            
            Spacer(minLength: 10)
            
            Divider()
            
            Button {
                defineUserViewModel.isVisibleOrientation.toggle()
            } label: {
                
                HStack {
                    if defineUserViewModel.isVisibleOrientation {
                        Image(systemName: "checkmark.square")
                    } else {
                        Image(systemName: "square")
                    }
                    
                    Text("Profilimde yönelimimi göster")
                        .font(.headline)
                }
                .foregroundColor(.gray)
     
                
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.vertical)
            
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

struct DefineOrientation_Previews: PreviewProvider {
    static var previews: some View {
        DefineOrientation()
            .environmentObject({ () -> DefineUserViewModel in return DefineUserViewModel() }() )
    }
}
