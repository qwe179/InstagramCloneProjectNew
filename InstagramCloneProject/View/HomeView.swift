//
//  NextView.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/02/27.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack(){
            TabView {
                FeedView().tabItem { Image("home") }.tag(1)
                ExploreView().tabItem { Image("Search") }.tag(2)
                NewBoardView().tabItem { Image("add_rec") }.tag(3)
                LikeView().tabItem { Image("heart") }.tag(4)
                MyView().tabItem { Image("Oval") }.tag(5)
             
            }
            
//            VStack {
//                Spacer()
//                Rectangle()
//                    .frame(maxWidth: .infinity, maxHeight: 1)
//                    .foregroundColor(Color(.gray).opacity(0.4))
//                    .padding(.bottom, 60)
//            }
            
        }.navigationBarHidden(true)
    }
}





#Preview {
    HomeView()
}
