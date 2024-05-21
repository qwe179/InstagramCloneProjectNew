//
//  NextView.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/02/27.
//

import SwiftUI
import UIKit
import AVFoundation

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var hideNavBar:Bool = true
    @State private var showCameraView = false
    @State private var selectedImage: UIImage = UIImage(named: "chichi")!
    var body: some View {
        ZStack(){
            NavigationView{
                TabView {
                    FeedView().tabItem { Image("home") }.tag(0)
                    ExploreView().tabItem { Image("Search") }.tag(1)
                    NewBoardView().tabItem { Image("Newphoto") }.tag(2)
                    ReelsView().tabItem { Image("Reel") }.tag(3)
                    MyView().tabItem { Image("Oval") }.tag(4)
                }
//                // MARK: - 툴바 순서 유의...
//                .toolbar {
//                    ToolbarItem(placement: .navigation) {
//                        VStack {
//                            HStack() {
//                                Button(action: {
//                                    self.showCameraView.toggle()
//                                }){
//                                    Image("camera")
//                                }
//                                // MARK: - 풀스크린하려면 .fullScreenCover 해야함.. .sheet 말고..
//
//                                .fullScreenCover(isPresented: $showCameraView, content: {
//                                    ImagePicker(image: $selectedImage, isActive: $showCameraView)
//                                        .edgesIgnoringSafeArea(.all)
//                                })
//                                
//                                Spacer()
//                                Image("instagramLogoWhite").resizable().aspectRatio(contentMode: .fit)
//                                    .frame(width: 105)
//                                Spacer()
//                                Image("dm")
//                               
//                              
//                              
//                            }
//                            .padding(.leading)
//                            .padding(.trailing)
//                            .frame(width: UIScreen.main.bounds.width)
//                            
//                        }//.background(.white)
//                        
//                    }
//                }.hideNavBarOnSwipe(hideNavBar)
            }
            
        }.navigationBarHidden(true)
            .onAppear {

            }
    }
}





#Preview {
    HomeView()
}
