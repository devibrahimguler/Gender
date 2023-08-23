//
//  DefinePhoto.swift
//  Gender
//
//  Created by İbrahim Güler on 4.07.2023.
//

import SwiftUI
import PhotosUI

struct DefinePhoto: View {
    
    var added : () -> ()

    @Binding var selected : [Int: UIImage]
    @Binding var defineCount : Int
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Button {
                defineCount -= 1
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
            
            VStack {
                ForEach(0...1, id:\.self) { i in
                    HStack {
                        Spacer()
                        
                        ForEach(0...2, id:\.self) { j in
                            PhotoSelectorButton(i: i < 1 ? (i + j) : (i + j + 2), croppedImage: $selected)
                        }
                        
                        Spacer()
                    }
                    
                }
            }
    
            Spacer(minLength: 10)
            
            Button {
                defineCount += 1
                added()
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
        TestDefinePhoto()
    }
    
    struct TestDefinePhoto : View {
        @ObservedObject var defineUserViewModel : DefineUserViewModel = DefineUserViewModel()
        
        var body: some View {
            VStack {
                DefinePhoto(added: defineUserViewModel.AddUser,selected: $defineUserViewModel.selectedPhoto, defineCount: $defineUserViewModel.defineCount)
            }
        }
    }
}
