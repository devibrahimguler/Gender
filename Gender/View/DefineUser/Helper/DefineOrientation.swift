//
//  DefineOrientation.swift
//  Gender
//
//  Created by İbrahim Güler on 16.07.2023.
//

import SwiftUI

struct DefineOrientation: View {
    
    var orientationTags : [String]
    
    @Binding var selected : [String]
    @Binding var defineCount : Int
    @Binding var isVisible : Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Button {
                    defineCount -= 1
                } label: {
                    Image(systemName: "chevron.backward")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)
                }
                
                Spacer(minLength: 10)
                
                Button {
                    defineCount += 1
                } label: {
                    Text("Skip")
                        .font(.system(size: 30))
                        .foregroundColor(.gray)
                }
            }
            .padding(.bottom)

            Text("Your sexual orientation?")
                .font(.system(size: 40, weight: .bold))
                .padding(.bottom, 10)
            
            Text("You can choose up to 5.")
                .font(.callout)
                .foregroundColor(.gray)
                .padding(.bottom, 10)
            
            VStack(spacing: 10) {
                ScrollView {
                    ForEach(orientationTags, id: \.self) { ori in
                        ListButton(text: ori, list: $selected)
                    }
                }
          
            }
            
          
            
            Spacer(minLength: 10)
            
            Divider()
            
            Button {
                isVisible.toggle()
            } label: {
                
                HStack {
                    if isVisible {
                        Image(systemName: "checkmark.square")
                    } else {
                        Image(systemName: "square")
                    }
                    
                    Text("Profilimde yönelimimi göster")
                        .font(.headline)
                }
                .foregroundColor(.gray)
     
                
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.vertical)
            
            Button {
                defineCount += 1
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

struct DefineOrientation_Previews: PreviewProvider {
    static var previews: some View {
        TestDefineOrientation()
    }
    
    struct TestDefineOrientation : View {
        @ObservedObject var defineUserViewModel : DefineUserViewModel = DefineUserViewModel()
        
        var body: some View {
            VStack {
                DefineOrientation(orientationTags: defineUserViewModel.orientationTags, selected: $defineUserViewModel.orientation, defineCount: $defineUserViewModel.defineCount, isVisible: $defineUserViewModel.isVisibleOrientation)
            }
        }
    }
}
