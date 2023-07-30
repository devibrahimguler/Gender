//
//  DefinePhoto.swift
//  Gender
//
//  Created by İbrahim Güler on 4.07.2023.
//

import SwiftUI
import PhotosUI

struct DefinePhoto: View {
    
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

            Text("Add your new photos")
                .font(.system(size: 40, weight: .bold))
            
            Text("Upload 2 photos to get started. Add at least 4 photos to make your profile stand out.")
                .font(.callout)
                .padding(.vertical,2)
            
            HStack {
                
                PhotoSelectorButton(selectedImage: $defineUserViewModel.foto1)
               
                Spacer()
                
                PhotoSelectorButton(selectedImage: $defineUserViewModel.foto2)
               
                
                Spacer()
                
                PhotoSelectorButton(selectedImage:  $defineUserViewModel.foto3)
               
         
            }
            HStack {
                
                PhotoSelectorButton(selectedImage:  $defineUserViewModel.foto4)
               
               
                Spacer()
                
                PhotoSelectorButton(selectedImage:  $defineUserViewModel.foto5)
               
                
                Spacer()
                
                PhotoSelectorButton(selectedImage:  $defineUserViewModel.foto6)
               
         
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

struct DefinePhoto_Previews: PreviewProvider {
    static var previews: some View {
        DefinePhoto()
            .environmentObject({ () -> DefineUserViewModel in return DefineUserViewModel() }() )
    }
}
