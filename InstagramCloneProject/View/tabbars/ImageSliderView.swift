//
//  ImageSliderView.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/02/29.
//

import SwiftUI
import BriefPagingControl

struct ImageSliderView: View {
    @State var offset:CGFloat = 0
    @State var tabIndex = 0
    @State private var temp = 0
  
    private let images = ["test", "chichi","test2", "test3", "test4", "test5"]
    var body: some View {
        VStack {

            TabView(selection: $tabIndex){
                ForEach(images.indices,id: \.self){ index in
                    VStack {
                        Image(images[index])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width)
                    }.background(.red)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode:.never))
            HStack{
                BriefPagingControl(numberOfPages: images.count, currentPage: $tabIndex) { config in
                    config.indicatorSize = 10
                    config.spacing = 10
                    config.currentIndicatorColor = .blue
                    config.indicatorColor = .black.opacity(0.15)
                    config.hidesForSinglePage = true
                    config.animation = .snappy
                }
            }
        }.background(.blue)
    }
    
}




#Preview {
    ImageSliderView()
}





