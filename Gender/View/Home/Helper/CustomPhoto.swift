//
//  CustomPhoto.swift
//  Gender
//
//  Created by İbrahim Güler on 4.09.2023.
//

import SwiftUI

struct CustomPhoto : View {
    
    @State var rotationEffect : Double = 0
    @State var submitEffect : Double = 0
    @State var photoGestur : CGPoint = .zero
    
    var image : Image
    var size : CGSize
    var likeColor : Color
    var disLikeColor : Color
    var superLikeColor : Color
    
    var body: some View {
        VStack {
            VStack {
                
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width)
                    .cornerRadius(10)
                    .gesture(
                        
                        DragGesture(coordinateSpace: .named("photo"))
                            .onChanged { value in
                                rotationEffect = -(photoGestur.x / 20)
                                photoGestur.x = value.location.x - size.width / 2
                            }
                            .onEnded { value in
                                if photoGestur.x <= -75 {
                                    //self.userSelection(selection: .DisLike)
                                } else if photoGestur.x >= 75 {
                                    //self.userSelection(selection: .Like)
                                }
                                rotationEffect = 0
                                photoGestur = .zero
                            }
                        
                    )
                 
                    .overlay {
                        if photoGestur.x <= -75 {
                            SlipText(text: " NOPE ", color: disLikeColor, isLike: false)
                        } else if photoGestur.x >= 75 {
                            SlipText(text: " LIKE ", color: likeColor, isLike: true)
                        }
                        
                    }
                    .shadow(color: .black, radius: 10, x:0, y: 10)
                    .position( x: photoGestur.x + (size.width / 2 ) , y: (size.height / 2 ) + submitEffect )
                    .rotationEffect(Angle(degrees: Double(rotationEffect) ))
                    .coordinateSpace(name: "photo")
                
            }
            .offset( y: submitEffect )
            .animation(.easeInOut, value: submitEffect == 0)
            
            
        }
    }
}

struct CustomPhotoPreview : PreviewProvider {
    static var previews: some View {
        TestCustomPhoto()
    }
    
    struct TestCustomPhoto : View {
        
        var likeColor : Color = Color("Like")
        var disLikeColor : Color = Color("DisLike")
        var superLikeColor : Color = Color("SuperLike")
        
        var body: some View {
            GeometryReader {
                let size = $0.size
                CustomPhoto(image: Image("sample"), size: size, likeColor: likeColor, disLikeColor: disLikeColor, superLikeColor: superLikeColor)
                
            }
            .padding(5)
            
        }
    }
}
