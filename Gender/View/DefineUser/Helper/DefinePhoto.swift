//
//  DefinePhoto.swift
//  Gender
//
//  Created by İbrahim Güler on 4.07.2023.
//

import SwiftUI
import PhotosUI

struct DefinePhoto: View {
    
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

            Text("Add your new photos")
                .font(.system(size: 40, weight: .bold))
            
            Text("Upload 2 photos to get started. Add at least 4 photos to make your profile stand out.")
                .font(.callout)
                .padding(.vertical,2)
            
            HStack {
                
                PhotoSelectorButton(croppedImage: $homeViewModel.foto1)
               
                Spacer()
                
                PhotoSelectorButton(croppedImage: $homeViewModel.foto2)
               
                
                Spacer()
                
                PhotoSelectorButton(croppedImage: $homeViewModel.foto3)
               
         
            }
            HStack {
                
                PhotoSelectorButton(croppedImage:  $homeViewModel.foto4)
               
               
                Spacer()
                
                PhotoSelectorButton(croppedImage:  $homeViewModel.foto5)
               
                
                Spacer()
                
                PhotoSelectorButton(croppedImage:  $homeViewModel.foto6)
               
         
            }
            Spacer(minLength: 10)
            
            Button {
                homeViewModel.defineCount += 1
                homeViewModel.isDefineUser = false
                homeViewModel.addUpdateUser()
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
            .environmentObject({ () -> HomeViewModel in return HomeViewModel() }() )
    }
}
