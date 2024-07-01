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
            }
            
        }.navigationBarHidden(true)
            .onAppear {

            }
    }
}

#Preview {
    HomeView()
}
