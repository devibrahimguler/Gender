//
//  PhotoSelectorButton.swift
//  Gender
//
//  Created by İbrahim Güler on 29.07.2023.
//

import SwiftUI
import PhotosUI

struct PhotoSelectorButton: View {
    var crop : CGSize = .init(width: 340, height: 500)
    @Binding var selectedImage : UIImage?
    @State private var isCropped : Bool = false
    
    @State private var showPicker : Bool = false
    @State var croppedImage : UIImage?
    @State var photosItem : PhotosPickerItem?
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 15)
                .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [5]))
                .overlay {
                    VStack {
                        if let croppedImage {
                            Image(uiImage: croppedImage)
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(25)
                        } else {
                            RoundedRectangle(cornerRadius: 13)
                                .fill(.gray)
                                .padding(2)
                        }
                    }

                }
                .frame(width: 85, height: 120)
                .padding(10)
                .overlay {
                    VStack {
                   Spacer()
                        HStack {
                            Spacer()
                            
                            Circle()
                                .fill(.orange)
                                .overlay {
                                    Button {
                                        showPicker = true
                                    } label: {
                                        Image(systemName: "plus")
                                            .resizable()
                                            .padding(11)
                                            .foregroundColor(.white)
                                    }
                                    
                                }
                                .frame(width: 40, height: 40, alignment: .bottom)
                        }
           
                    }
                }
        }
        .photosPicker(isPresented: $showPicker, selection: $photosItem)
        .onChange(of: photosItem) { newValue in
            if let newValue {
                Task {
                    if let imageData = try? await newValue.loadTransferable(type: Data.self), let image = UIImage(data: imageData) {
                        await MainActor.run(body: {
                            selectedImage = image
                            isCropped = true
                        })
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $isCropped) {
            selectedImage = nil
            isCropped = false
        } content: {
            CropView(crop: crop, image: selectedImage) { croppedImage, status in
                if let croppedImage {
                    self.croppedImage = croppedImage
                }
            }
        }
    }
}
