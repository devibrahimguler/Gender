//
//  PhotoCounter.swift
//  Gender
//
//  Created by İbrahim Güler on 4.09.2023.
//

import SwiftUI

struct PhotoCounter: View {
    
    @Binding var id : Int
    
    var name : String
    var description : String
    var count : Int
    var size : CGSize
    var likeColor : Color
    var disLikeColor : Color
    var superLikeColor : Color
    var complation : (SenseButtonType) -> ()
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                ForEach(0...count, id:\.self) { i in
                    
                    Button {
                        id = i
                    } label: {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .frame(height: 5)
                            .foregroundColor(id == i ? .blue : .gray)
                            .animation(.easeInOut, value: id == i)
                            .opacity(0.7)
                    }
                }
            }
            
            Spacer()

            VStack(alignment: .leading) {
                Text(name)
                    .font(.title.bold())
                  
                Text(description)
                    .font(.subheadline)
                  
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding([.bottom, .leading], 25)
            .shadow(color: .black,radius: 3)
           

            HStack {
                ForEach(SenseButtonType.allCases, id:\.self) { sense in
            
                    Spacer()
                    
                    SelectButton(sense: sense) {
                        complation(sense)
                    }

                    Spacer()
                }

            }
        }
        .frame(width: size.width)
        .padding(.bottom, 25)
    }
}

struct PhotoCounter_Previews: PreviewProvider {
    static var previews: some View {
        TestPhotoCounter()
    }
    
    struct TestPhotoCounter : View {
        
        @State var id : Int = 0
        var count : Int = 5
        var likeColor : Color = Color("Like")
        var disLikeColor : Color = Color("DisLike")
        var superLikeColor : Color = Color("SuperLike")
        
        var body: some View {
            GeometryReader {
                let size = $0.size
                PhotoCounter(id: $id, name: "Name, 24", description: "Üniversite", count: count, size: size, likeColor: likeColor, disLikeColor: disLikeColor, superLikeColor: superLikeColor) { sense in
                    print(sense.rawValue)
                }
            }
        }
    }
}


