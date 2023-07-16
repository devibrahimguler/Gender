//
//  DefineHobies.swift
//  Gender
//
//  Created by İbrahim Güler on 4.07.2023.
//

import SwiftUI

struct DefineHobies: View {
    
    @EnvironmentObject var homeViewModel : HomeViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Button {
                    homeViewModel.defineCount -= 1
                } label: {
                    Image(systemName: "chevron.backward")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)
                }
                
                Spacer(minLength: 10)
                
                Button {
                    homeViewModel.defineCount -= 1
                } label: {
                    Text("Skip")
                        .font(.system(size: 30))
                        .foregroundColor(.gray)
                }
            }
            .padding(.bottom, 20)

            Text("What are the topics that interest you?")
                .font(.system(size: 40, weight: .bold))
            
            Text("Surely you have areas of interest. Now show them to everyone.")
                .font(.callout)
            
            Divider()
            
            GeometryReader { geo in
                        ScrollView(.vertical) {
                            Text("Deneme").frame(
                                minWidth: geo.size.width,
                                minHeight: geo.size.height
                            )
                            Text("Denemeadsadasdas").frame(
                                minWidth: geo.size.width,
                                minHeight: geo.size.height
                            )
                            Text("Denemeasdasdasdasd").frame(
                                minWidth: geo.size.width,
                                minHeight: geo.size.height
                            )
                            Text("Denemedasdasdasd").frame(
                                minWidth: geo.size.width,
                                minHeight: geo.size.height
                            )
                            Text("Denemasdae").frame(
                                minWidth: geo.size.width,
                                minHeight: geo.size.height
                            )
                            Text("asdasdas asdasedasd ada dasd adsasda").frame(
                                minWidth: geo.size.width,
                                minHeight: geo.size.height
                            )
                        }
                    }
            
            Spacer(minLength: 10)
            
            Divider()
            
            Button {
                homeViewModel.defineCount += 1
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

struct DefineHobies_Previews: PreviewProvider {
    static var previews: some View {
        DefineHobies()
            .environmentObject({ () -> HomeViewModel in return HomeViewModel() }() )
    }
    
}
