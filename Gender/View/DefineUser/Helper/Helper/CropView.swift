//
//  CropView.swift
//  Gender
//
//  Created by İbrahim Güler on 30.07.2023.
//

import SwiftUI

struct CropView : View {
    var crop: CGSize = .init(width: 340, height: 500)
    var image : UIImage?
    var onCrop : (UIImage?, Bool) -> ()
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var scale : CGFloat = 1
    @State private var lastScale : CGFloat = 0
    @State private var offset : CGSize = .zero
    @State private var lastStoredOffset : CGSize = .zero
    @GestureState private var isInteracting : Bool = false
    
    var body: some View {
        NavigationStack {
            ImageView()
                .navigationTitle("Crop View")
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarBackground(Color.black, for: .navigationBar)
                .toolbarColorScheme(.dark, for: .navigationBar)
                 .frame(maxWidth: .infinity, maxHeight: .infinity)
                 .background {
                     Color.black
                         .ignoresSafeArea()
                 }
                 .toolbar {
                     ToolbarItem(placement: .navigationBarTrailing) {
                         Button {
                             let renderer = ImageRenderer(content: ImageView())
                             renderer.proposedSize = .init(crop)
                             if let image = renderer.uiImage {
                                 onCrop(image, true)
                             } else {
                                 onCrop(nil, false)
                             }
                             dismiss()
                         } label: {
                             Image(systemName: "checkmark")
                                 .font(.callout)
                                 .fontWeight(.semibold)
                         }

                     }
                     
                     ToolbarItem(placement: .navigationBarLeading) {
                         Button {
                             dismiss()
                         } label: {
                             Image(systemName: "xmark")
                                 .font(.callout)
                                 .fontWeight(.semibold)
                         }

                     }
                 }
        }
    }
    
    
    // func ImageView(_ hideGrids: Bool = false)
    @ViewBuilder
    func ImageView() -> some View {
        let cropSize = crop
        GeometryReader {
            let size = $0.size
            
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .overlay(content: {
                        GeometryReader { proxy in
                            let rect = proxy.frame(in: .named("CROPVIEW"))
                            
                            Color.clear
                                .onChange(of: isInteracting) { newValue in
                                    
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        if rect.minX > 0 {
                                            offset.width = (offset.width - rect.minX)
                                        }
                                        
                                        if rect.minY > 0 {
                                            offset.height = (offset.height - rect.minY)
                                        }
                                        
                                        if rect.maxX < size.width {
                                            offset.width = (rect.minX - offset.width)
                                        }
                                        
                                        if rect.maxY < size.height {
                                            offset.height = (rect.minY - offset.height)
                                        }
                                    }
                                    if !newValue {
                                        lastStoredOffset = offset
                                    }
                                }
                        }
                    })
                    .frame(width: size.width, height: size.height)
                   
            }
        }
        .scaleEffect(scale)
        .offset(offset)
        /*
         .overlay(content: {
             if !hideGrids {
                 Grids()
             }
         })
         */
        .coordinateSpace(name: "CROPVIEW")
        .gesture(
        DragGesture()
            .updating($isInteracting, body: { _, out, _ in
                out = true
            })
            .onChanged({ value in
                let translation = value.translation
                offset = CGSize(width: translation.width + lastStoredOffset.width, height: translation.height + lastStoredOffset.height)
            })
        )
        .gesture(
        MagnificationGesture()
            .updating($isInteracting, body: { _, out, _ in
                out = true
            })
            .onChanged({ value in
                let updatedScale = value + lastScale
                scale = (updatedScale < 1 ? 1 : updatedScale)
            })
            .onEnded({ value in
                withAnimation(.easeInOut(duration: 0.2)) {
                    if scale < 1 {
                        scale = 1
                        lastScale = 0
                    } else {
                        lastScale = scale - 1
                    }
                }
            })
        )
        .frame(width: cropSize.width, height: cropSize.height)
    }
    
   /*
    @ViewBuilder
    func Grids() -> some View {
        ZStack {
            HStack {
                ForEach(1...5, id: \.self) { _ in
                    Rectangle()
                        .fill(.white.opacity(0.7))
                        .frame(width: 1)
                        .frame(maxWidth: .infinity)
                }
            }
            VStack {
                ForEach(1...8, id: \.self) { _ in
                    Rectangle()
                        .fill(.white.opacity(0.7))
                        .frame(height: 1)
                        .frame(maxHeight: .infinity)
                }
            }
        }
    }
    */
    
}

struct CropView_Previews: PreviewProvider {
    static var previews: some View {
        CropView { _, _ in
            
        }
    }
}
