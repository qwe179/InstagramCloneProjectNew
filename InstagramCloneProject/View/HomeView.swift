//
//  NextView.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/02/27.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var hideNavBar:Bool = true
    var body: some View {
        ZStack(){
            NavigationView{
                TabView {
                    FeedView().tabItem { Image("home") }.tag(1)
                    ExploreView().tabItem { Image("Search") }.tag(2)
                    NewBoardView().tabItem { Image("add_rec") }.tag(3)
                    LikeView().tabItem { Image("heart") }.tag(4)
                    MyView().tabItem { Image("Oval") }.tag(5)
                }
                // MARK: - 툴바 순서 유의...
                .toolbar {
                    ToolbarItem(placement: .navigation) {
                        VStack {
                            HStack() {
                                Image("camera")
                                Spacer()
                                Image("instagramLogoWhite").resizable().aspectRatio(contentMode: .fit)
                                    .frame(width: 105)
                                Spacer()
                                Image("dm")
                            }
                            .padding(.leading)
                            .padding(.trailing)
                            .frame(width: UIScreen.main.bounds.width)
                            
                        }//.background(.white)
                        
                    }
                }.hideNavBarOnSwipe(hideNavBar)
            }
            
        }.navigationBarHidden(true)
    }
}





#Preview {
    HomeView()
}
