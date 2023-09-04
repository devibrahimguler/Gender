//
//  PhotoSelection.swift
//  Gender
//
//  Created by İbrahim Güler on 16.08.2023.
//

import SwiftUI

struct PhotoSelection: View {
    
    @EnvironmentObject var mainViewModel : MainViewModel
        
    var likeColor : Color = Color("Like")
    var disLikeColor : Color = Color("DisLike")
    var superLikeColor : Color = Color("SuperLike")
    
    var body: some View {
        VStack {
             if mainViewModel.isStartSearched {
                 if mainViewModel.randomPhoto.count > 0 {
                     if let image = mainViewModel.randomPhoto[mainViewModel.photoId] {
                         GeometryReader {
                             let size = $0.size
                             
              
                             ZStack {
                                 CustomPhoto(image: image, size: size, likeColor: likeColor, disLikeColor: disLikeColor, superLikeColor: superLikeColor)
                                 .onTapGesture(perform: { point in
                                     
                                     if point.x > 191 && point.y < 344 {
                                         
                                         if (mainViewModel.randomPhoto.count - 1) > mainViewModel.photoId {
                                             mainViewModel.photoId += 1
                                         }
                                     } else if point.x < 191 && point.y < 344 {
                                         if mainViewModel.photoId > 0 {
                                             mainViewModel.photoId -= 1
                                         }
                                     }
                                     
                                     
                                     
                                 })
                             
                                 PhotoCounter(id: $mainViewModel.photoId,
                                              name: mainViewModel.randomUser?.name ?? "Name",
                                              description: mainViewModel.randomUser?.school ?? "School",
                                              count: (mainViewModel.randomPhoto.count - 1),
                                              size: size,
                                              likeColor: likeColor,
                                              disLikeColor: disLikeColor,
                                              superLikeColor: superLikeColor) { sense in
                                     
                                     mainViewModel.userSelection(sense: sense)
                                 }
                                 
                                 
                             }
                             .offset( y: mainViewModel.submitEffect )
                             .animation(.easeInOut, value: mainViewModel.submitEffect == 0)
                             
                         }
                         .padding(5)
                         
                         
                         
                     }
                 }
             }
             else {
                 Button {
                     mainViewModel.getUser()
                     mainViewModel.isStartSearched = true
                 } label: {
                     ZStack {
                         Text("Click for Start")
                             .font(.system(size: 100, design: .rounded).bold())
                             .foregroundColor(.black)
                         
                         Image(systemName: "i.square")
                             .resizable()
                             .aspectRatio(contentMode: .fit)
                             .padding(20)
                             .blur(radius: mainViewModel.isStartSearched ? 0 : 20)
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
        @StateObject var mainViewModel : MainViewModel = MainViewModel()

        @State var user = GenderUser()
        var body: some View {
            PhotoSelection()
                .environmentObject(mainViewModel)
                .onAppear {
                    self.user = GenderUser(
                        id: "Test",
                        name: "Selin",
                        age: "18",
                        birthDay: "20/05/2005",
                        livecity: "Türkiye",
                        gender: "Female",
                        school: "Ege Üniversitesi",
                        isVisibleGender: true,
                        isVisibleOrientation: true,
                        defineUser: true,
                        orientation: ["heterosexsuel"],
                        photos: [
                        "Test/Test1.jpg",
                        "Test/Test2.jpg",
                        "Test/Test3.jpg",
                        "Test/Test4.jpg",
                        "Test/Test5.jpg",
                        "Test/Test6.jpg",
                        "Test/Test7.jpg",
                        "Test/Test8.jpg"],
                        hobies: ["Foutball","Basketball"],
                        likes: [],
                        dislike: [],
                        superlike: [])
                    
                    self.mainViewModel.currentUser = self.user
                    self.mainViewModel.randomUser = self.user
                    
                    if let user = self.mainViewModel.randomUser {
                        self.mainViewModel.users.append(user)
                    }
                }
        }
    }
}
