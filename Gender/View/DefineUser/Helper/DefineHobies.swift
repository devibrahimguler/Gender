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
                    homeViewModel.defineCount += 1
                } label: {
                    Text("Skip")
                        .font(.system(size: 30))
                        .foregroundColor(.gray)
                }
            }
            .padding(.bottom)
            
            Text("What are the topics that interest you?")
                .font(.system(size: 40, weight: .bold))
            
            Text("Surely you have areas of interest. Now show them to everyone.")
                .font(.callout)
                .padding(.vertical,10)
            
            Divider()
            
            
            ScrollView(.vertical) {
                VStack {
                    GeometryReader { geometry in
                        var width = CGFloat.zero
                        var height = CGFloat.zero

                        ZStack(alignment: .topLeading) {
                            ForEach(homeViewModel.hobiesTags, id: \.self) { tag in
                                self.item(for: tag)
                                    .padding([.horizontal, .vertical], 4)
                                    .alignmentGuide(.leading, computeValue: { d in
                                        if (abs(width - d.width) > geometry.size.width)
                                        {
                                            width = 0
                                            height -= d.height
                                        }
                                        let result = width
                                        if tag == homeViewModel.hobiesTags.last! {
                                            width = 0 //last item
                                        } else {
                                            width -= d.width
                                        }
                                        return result
                                    })
                                    .alignmentGuide(.top, computeValue: {d in
                                        let result = height
                                        if tag == homeViewModel.hobiesTags.last! {
                                            height = 0 // last item
                                        }
                                        return result
                                    })
                            }
                        }.background(viewHeightReader($homeViewModel.totalHeight))
                    }
                }
                .frame(height: homeViewModel.totalHeight)
            }
            
            Spacer(minLength: 10)
            
            Divider()
            
            Button {
                if  homeViewModel.selectedHobiesList.count >= 1 {
                    homeViewModel.defineCount += 1
                }
            } label: {
                Text("Go On! \( homeViewModel.selectedHobiesList.count)/5")
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background( homeViewModel.selectedHobiesList.count == 0 ?.gray : .red)
                    .bold()
                    .foregroundColor(.white)
                    .cornerRadius(50)
             
                
            }
            .disabled( homeViewModel.selectedHobiesList.count == 0)
            
        }
        .padding(20)
    }
    
    private func item(for text: String) -> some View {
        Button {
            
            if homeViewModel.selectedHobiesList.contains(text)  {
                if homeViewModel.selectedHobiesList.count > 0 {
                    if let index = homeViewModel.selectedHobiesList.firstIndex(of: text) {
                        homeViewModel.selectedHobiesList.remove(at: index)
                    }
                }
            } else {
                if homeViewModel.selectedHobiesList.count < 5 {
                    homeViewModel.selectedHobiesList.append(text)
                    
                }
            }
        } label: {
            Text(text)
                .font(.body)
                .foregroundColor(homeViewModel.selectedHobiesList.contains(text) ? .blue : .gray)
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .overlay {
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(lineWidth: 1)
                        .fill(homeViewModel.selectedHobiesList.contains(text) ? .blue : .gray)
                }
        }

    }

    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
    
}

struct DefineHobies_Previews: PreviewProvider {
    static var previews: some View {
        DefineHobies()
            .environmentObject({ () -> HomeViewModel in return HomeViewModel() }() )
    }
    
}
