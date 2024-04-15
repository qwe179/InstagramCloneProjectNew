//
//  testview.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/03/27.
//

import SwiftUI

struct CustomSliderView: View {
    @Binding var currentIndex: Int
     var currentIndex2: Int = 0
    let views: [AnyView] 
//    = [
//        AnyView(Text("View 1")),
//        AnyView(Text("View 2")),
//        AnyView(Text("View 2")),
//        AnyView(Text("View 2")),
//        AnyView(Text("View 2")),
//        AnyView(Text("View 2")),
//        AnyView(Text("View 2")),
//        AnyView(Text("View 2")),
//        AnyView(Text("View 2")),
//        AnyView(Text("View 2")),
//        AnyView(Text("View 2")),
//        AnyView(Text("View 2")),
//        AnyView(Text("View 3"))
//        
//    ]

  
    var body: some View {
   //     GeometryReader { geometry in
            if #available(iOS 17.0, *) {
                ScrollView(.horizontal, showsIndicators: false) {
                    ScrollViewReader { proxy in
                        HStack(spacing: 0) {
                            ForEach(views.indices, id: \.self) { index in
                                views[index]
                             //       .frame(width: geometry.size.width, height: geometry.size.height)
                                    .id(index) // ScrollViewReader의 proxy에서 사용할 유일한 식별자를 설정합니다.
                            }
                        }
                        
                        .onChange(of: currentIndex) { _ in
                            // currentIndex가 변경될 때마다 해당 뷰로 스크롤
                            withAnimation {
                                proxy.scrollTo(currentIndex-1, anchor: .leading)
                                print("currentIndex2",currentIndex)
                            }
                        }
                    }
                }
                .scrollTargetBehavior(.paging)
            }
       // }
      //  .edgesIgnoringSafeArea(.all)
        
//        .overlay(
//            Button(action: {
//                // 다음 버튼이 눌리면 다음 뷰로 이동
//                currentIndex = (currentIndex + 1) % views.count
//            }) {
//                Image(systemName: "arrow.right.circle.fill")
//                    .font(.largeTitle)
//                    .foregroundColor(.blue)
//            }
//            .padding(20),
//            alignment: .bottomTrailing
//        )
    }
}
//
//struct ContentView2: View {
//    let images = ["chichi", "chichi", "chichi"] // 이미지 이름은 프로젝트에 추가되어 있어야 합니다.
//
//    var body: some View {
//        CustomSliderView()
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomSliderView()
//    }
//}
