//
//  PhotoSelection.swift
//  Gender
//
//  Created by İbrahim Güler on 16.08.2023.
//

import SwiftUI

struct PhotoSelection: View {
    
    @EnvironmentObject var homeViewModel : HomeViewModel
    
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
                                                homeViewModel.changedGestureVlue(value: value, proxy: proxy)
                                            }
                                            .onEnded { value in
                                                homeViewModel.endGestureVlue()
                                            }
                                    )
                                    .onTapGesture(perform: { point in
                                        homeViewModel.photoItulater(point: point)
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
                                                .foregroundColor(homeViewModel.disLikeColor)
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
                                                .foregroundColor(homeViewModel.likeColor)
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
                                            homeViewModel.addDisLikeList()
                                        } label: {
                                            Image(systemName: "xmark")
                                                .resizable()
                                                .bold()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 25, height: 25)
                                                .foregroundColor(homeViewModel.disLikeColor)
                                                .overlay {
                                                    Circle()
                                                        .stroke(lineWidth: 2)
                                                        .frame(width: 50, height: 50)
                                                        .foregroundColor(homeViewModel.disLikeColor)
                                                }
                                        }
                                        
                                        Button {
                                            homeViewModel.addSuperLikeList()
                                        } label: {
                                            Image(systemName: "star.fill")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 25, height: 25)
                                                .foregroundColor(homeViewModel.superLikeColor)
                                                .overlay {
                                                    Circle()
                                                        .stroke(lineWidth: 2)
                                                        .frame(width: 50, height: 50)
                                                        .foregroundColor(homeViewModel.superLikeColor)
                                                }
                                        }
                                        
                                        
                                        Button {
                                            homeViewModel.addLikeList()
                                        } label: {
                                            Image(systemName: "suit.heart.fill")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 25, height: 25)
                                                .foregroundColor(homeViewModel.likeColor)
                                                .overlay {
                                                    Circle()
                                                        .stroke(lineWidth: 2)
                                                        .frame(width: 50, height: 50)
                                                        .foregroundColor(homeViewModel.likeColor)
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
                    self.homeViewModel.randomUser = GenderUser(id: "hKIdJLVxSgVjUoU6T4lhOIFSZdN2",name: "ibrahim", age: "24", birthDay: "13/04/1999", livecity: "", gender: "Male", isVisibleGender: true, isVisibleOrientation: true, defineUser: true, orientation: ["heterosexsuel"], photos: [
                        "hKIdJLVxSgVjUoU6T4lhOIFSZdN2/hKIdJLVxSgVjUoU6T4lhOIFSZdN21.jpg",
                        "hKIdJLVxSgVjUoU6T4lhOIFSZdN2/hKIdJLVxSgVjUoU6T4lhOIFSZdN22.jpg",
                        "hKIdJLVxSgVjUoU6T4lhOIFSZdN2/hKIdJLVxSgVjUoU6T4lhOIFSZdN23.jpg"], hobies: ["Foutball","Basketball"], likes: [], dislike: [], superlike: [])
                    
                    if let user = self.homeViewModel.randomUser {
                        self.homeViewModel.users.append(user)
                    }
                }
        }
    }
}
