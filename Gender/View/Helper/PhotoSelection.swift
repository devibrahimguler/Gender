//
//  PhotoSelection.swift
//  Gender
//
//  Created by İbrahim Güler on 16.08.2023.
//

import SwiftUI

struct PhotoSelection: View {
    
    @EnvironmentObject var homeViewModel : HomeViewModel
        
    var likeColor : Color = Color("Like")
    var disLikeColor : Color = Color("DisLike")
    var superLikeColor : Color = Color("SuperLike")
    
    var body: some View {
        VStack {
             if homeViewModel.isStartSearched {
                 if homeViewModel.randomPhoto.count > 0 {
                     if let data = homeViewModel.randomPhoto[homeViewModel.photoId] {
                         GeometryReader { proxy in
                             ZStack {

                                 Image(uiImage: data)
                                     .resizable()
                                     .cornerRadius(10)
                                     .gesture(
                                         DragGesture(coordinateSpace: .named("photo"))
                                             .onChanged { value in
                                                 homeViewModel.changedGestureValue(value: value, proxy: proxy)
                                             }
                                             .onEnded { value in
                                                 homeViewModel.endGestureValue()
                                             }
                                     )
                                     .onTapGesture(perform: { point in
                                         homeViewModel.getUserPhotos(point: point)
                                     })
                                     .overlay {
                                         if homeViewModel.photoGestur.x <= -75 {
                                             Text("NOPE")
                                                 .font(.system(size: 40))
                                                 .bold()
                                                 .padding(10)
                                                 .overlay {
                                                     RoundedRectangle(cornerRadius: 10)
                                                         .stroke(lineWidth: 3)
                                                     
                                                 }
                                                 .foregroundColor(disLikeColor)
                                                 .opacity(0.6)
                                                 .rotationEffect(Angle(degrees: 10))
                                                 .offset(x: 100, y: -200)
                                                 .animation(.linear, value: homeViewModel.photoGestur.x <= -100)
                                             
                                         } else if homeViewModel.photoGestur.x >= 75 {
                                             
                                             Text(" LIKE ")
                                                 .font(.system(size: 40))
                                                 .bold()
                                                 .padding(10)
                                                 .overlay {
                                                     RoundedRectangle(cornerRadius: 10)
                                                         .stroke(lineWidth: 3)
                                                     
                                                 }
                                                 .foregroundColor(likeColor)
                                                 .opacity(0.6)
                                                 .rotationEffect(Angle(degrees: -10))
                                                 .offset(x: -100, y: -200)
                                                 .animation(.linear, value: homeViewModel.photoGestur.x >= 100)
                                             
                                         }
                                     }
                                     .position( x:(homeViewModel.photoGestur.x * 2) + (proxy.size.width / 2)  + (homeViewModel.rotationEffect * -5) , y: (proxy.size.height / 2) + homeViewModel.submitEffect )
                                     .rotationEffect(Angle(degrees: Double(homeViewModel.rotationEffect) ))
                                   
                                     .coordinateSpace(name: "photo")
                             
                                 
                                 Spacer()
                                 
                                 VStack {
                                     HStack(spacing: 0) {
                                         ForEach(0...homeViewModel.randomPhoto.count - 1, id:\.self) { i in
                                             
                                             Button {
                                                 homeViewModel.photoId = i
                                             } label: {
                                                 RoundedRectangle(cornerRadius: 2)
                                                     .foregroundColor(homeViewModel.photoId == i ? .blue : .gray)
                                                     .animation(.easeInOut, value: homeViewModel.photoId == i)
                                                     .frame(height: 5)
                                                 
                                             }
                                         }
                                     }
                                     .frame(alignment: .top)
                                     
                                     Spacer()
                                     
                                     HStack(spacing: 80) {
                                         Button {
                                             homeViewModel.userSelection(selection: .DisLike)
                                         } label: {
                                             Image(systemName: "xmark")
                                                 .resizable()
                                                 .bold()
                                                 .aspectRatio(contentMode: .fit)
                                                 .frame(width: 25, height: 25)
                                                 .foregroundColor(disLikeColor)
                                                 .overlay {
                                                     Circle()
                                                         .stroke(lineWidth: 2)
                                                         .frame(width: 50, height: 50)
                                                         .foregroundColor(disLikeColor)
                                                 }
                                         }
                                         
                                         Button {
                                             homeViewModel.userSelection(selection: .SuperLike)
                                         } label: {
                                             Image(systemName: "star.fill")
                                                 .resizable()
                                                 .aspectRatio(contentMode: .fit)
                                                 .frame(width: 25, height: 25)
                                                 .foregroundColor(superLikeColor)
                                                 .overlay {
                                                     Circle()
                                                         .stroke(lineWidth: 2)
                                                         .frame(width: 50, height: 50)
                                                         .foregroundColor(superLikeColor)
                                                 }
                                         }
                                         
                                         
                                         Button {
                                             homeViewModel.userSelection(selection: .Like)
                                         } label: {
                                             Image(systemName: "suit.heart.fill")
                                                 .resizable()
                                                 .aspectRatio(contentMode: .fit)
                                                 .frame(width: 25, height: 25)
                                                 .foregroundColor(likeColor)
                                                 .overlay {
                                                     Circle()
                                                         .stroke(lineWidth: 2)
                                                         .frame(width: 50, height: 50)
                                                         .foregroundColor(likeColor)
                                                 }
                                         }
                                         
                                     }
                                     .frame(alignment: .bottom)
                                 }
                                 .padding(10)
                                 .padding(.bottom, 20)
                                 
                                 
                             }
                             .offset( y: homeViewModel.submitEffect )
                             .animation(.easeInOut, value: homeViewModel.submitEffect == 0)
                             
                         }
                         .padding(5)
                         
                         
                         
                     }
                 }
             }
             else {
                 Button {
                     homeViewModel.getUser()
                     homeViewModel.isStartSearched = true
                 } label: {
                     ZStack {
                         Text("Click for Start")
                             .font(.system(size: 100, design: .rounded).bold())
                             .foregroundColor(.black)
                         
                         Image(systemName: "i.square")
                             .resizable()
                             .aspectRatio(contentMode: .fit)
                             .padding(20)
                             .blur(radius: homeViewModel.isStartSearched ? 0 : 20)
                             .foregroundColor(.white)
                     }
                 }
                 
             }
        }
        .padding(.vertical, 30)
        
        
    }
}

struct PhotoSelection_Previews: PreviewProvider {
    static var previews: some View {
        TestPhotoSelection()
    }
    
    struct TestPhotoSelection: View {
        @StateObject var homeViewModel : HomeViewModel = HomeViewModel()
        
        var body: some View {
            PhotoSelection()
                .environmentObject(homeViewModel)
                .onAppear {
                    self.homeViewModel.randomUser = GenderUser(id: "iZH2QFZrXEZxpnZxudYNUJsctus2",name: "ibrahim", age: "24", birthDay: "13/04/1999", livecity: "", gender: "Male", isVisibleGender: true, isVisibleOrientation: true, defineUser: true, orientation: ["heterosexsuel"], photos: [
                        "iZH2QFZrXEZxpnZxudYNUJsctus2/iZH2QFZrXEZxpnZxudYNUJsctus21.jpg",
                        "iZH2QFZrXEZxpnZxudYNUJsctus2/iZH2QFZrXEZxpnZxudYNUJsctus22.jpg",
                        "iZH2QFZrXEZxpnZxudYNUJsctus2/iZH2QFZrXEZxpnZxudYNUJsctus23.jpg"], hobies: ["Foutball","Basketball"], likes: [], dislike: [], superlike: [])
                    
                    if let user = self.homeViewModel.randomUser {
                        self.homeViewModel.users.append(user)
                    }
                }
        }
    }
}
