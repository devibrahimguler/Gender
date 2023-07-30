//
//  DefineHobies.swift
//  Gender
//
//  Created by İbrahim Güler on 4.07.2023.
//

import SwiftUI

struct DefineHobies: View {
    
    @EnvironmentObject var defineUserViewModel : DefineUserViewModel
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            HStack {
                Button {
                    defineUserViewModel.defineCount -= 1
                } label: {
                    Image(systemName: "chevron.backward")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)
                }
                
                Spacer(minLength: 10)
                
                Button {
                    defineUserViewModel.defineCount += 1
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
                            ForEach(defineUserViewModel.tags, id: \.self) { tag in
                                self.item(for: tag)
                                    .padding([.horizontal, .vertical], 4)
                                    .alignmentGuide(.leading, computeValue: { d in
                                        if (abs(width - d.width) > geometry.size.width)
                                        {
                                            width = 0
                                            height -= d.height
                                        }
                                        let result = width
                                        if tag == defineUserViewModel.tags.last! {
                                            width = 0 //last item
                                        } else {
                                            width -= d.width
                                        }
                                        return result
                                    })
                                    .alignmentGuide(.top, computeValue: {d in
                                        let result = height
                                        if tag == defineUserViewModel.tags.last! {
                                            height = 0 // last item
                                        }
                                        return result
                                    })
                            }
                        }.background(viewHeightReader($defineUserViewModel.totalHeight))
                    }
                }
                .frame(height: defineUserViewModel.totalHeight)
            }
            
            
            
            Spacer(minLength: 10)
            
            Divider()
            
            Button {
                if defineUserViewModel.selectedTags >= 1 {
                    defineUserViewModel.defineCount += 1
                }
            } label: {
                Text("Go On! \(defineUserViewModel.selectedTags)/5")
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(defineUserViewModel.selectedTags == 0 ?.gray : .red)
                    .bold()
                    .foregroundColor(.white)
                    .cornerRadius(50)
             
                
            }
            .disabled(defineUserViewModel.selectedTags == 0)
            
        }
        .padding(20)
    }
    
    private func item(for text: String) -> some View {
        Button {
            
            if defineUserViewModel.selectedList.contains(text)  {
                if defineUserViewModel.selectedTags > 0 {
                    defineUserViewModel.selectedTags -= 1
                    if let index = defineUserViewModel.selectedList.firstIndex(of: text) {
                        defineUserViewModel.selectedList.remove(at: index)
                    }
                }
            } else {
                if defineUserViewModel.selectedTags < 5 {
                    defineUserViewModel.selectedTags += 1
                    defineUserViewModel.selectedList.append(text)
                    
                }
            }
        } label: {
            Text(text)
                .font(.body)
                .foregroundColor(defineUserViewModel.selectedList.contains(text) ? .blue : .gray)
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .overlay {
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(lineWidth: 1)
                        .fill(defineUserViewModel.selectedList.contains(text) ? .blue : .gray)
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
            .environmentObject({ () -> DefineUserViewModel in return DefineUserViewModel() }() )
    }
    
}
