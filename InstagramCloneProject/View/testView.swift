//
//  testView.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/03/03.
//

import SwiftUI

//
//struct testView: View {
//    @StateObject private var viewModel: ViewModel = ViewModel()
//    private var scrollObservableView: some View {
//        GeometryReader { proxy in
//            let offsetY = proxy.frame(in: .global).origin.y
//            Color.clear
//                .preference(
//                    key: ScrollOffsetKey.self,
//                    value: offsetY
//                )
//                .onAppear {
//                    viewModel.setOriginOffset(offsetY)
//                }
//        }
//        .frame(height: 0)
//    }
//    
//    var body: some View {
//        Color.blue
//            .frame(height: 50)
//            .offset(y:viewModel.offset - viewModel.originOffset < 0 ?  viewModel.offset - viewModel.originOffset : 0 )
//        List {
//            ZStack {
//                scrollObservableView
//                Color.red
//                Text("1")
//            } .frame(height: 50)
//        }
//        .clipped()
//        .onPreferenceChange(ScrollOffsetKey.self) { i in
//            viewModel.setOffset(i)
//        }
//    }
//
//    struct ScrollOffsetKey: PreferenceKey {
//        static var defaultValue: CGFloat = .zero
//        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
//            // MARK: - 내부적으로 뭔가 잘못되있는거 수정함
//
//            if value == 0 {
//                value += nextValue()
//            }
//        }
//    }
//}
//
//
//#Preview {
//    testView()
//}
