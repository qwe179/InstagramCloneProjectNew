//
//  UserView.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/02/28.
//

import SwiftUI
import BriefPagingControl
import Kingfisher
import SlidingTabView
//import SwiftUIIntrospect
import AVKit
import AVFoundation
import NavigationTransitions

struct MyView: View {
    @StateObject private var viewModel: ViewModel = ViewModel()
    @State private var tabViewHeight: CGFloat = 300 // 초기값 설정
    @State private var tabIndex = 1
    @Namespace var topID1
    @Namespace var topID2
    @Namespace var topID3
    var body: some View {
        

        NavigationView {
 
            ScrollView {
                VStack {
                    // MARK: - 프로필, 게시판,팔로워,팔로잉
                    HStack(spacing:50) {
                        Button {
                            
                        } label: {
                            //Image(.chichi)
                            KFImage(URL(string: "https://cdn.imweb.me/thumbnail/20230308/8e3353bb9aad0.jpg"))
                                .resizable()
                              //  .aspectRatio(contentMode: .fit)
                                .frame(width: 80,height: 80)
                                //.frame(width: 80)
                                //   .defualt()
                                .clipShape(Circle())
                               
                                .overlay {
                                    Image(systemName: "plus.circle.fill")
                                        .padding(2)
                                        .background(.white)
                                        .clipShape(.circle)
                                        .offset(x:30,y:30)
                                }
                        }
                       
                        Button {
                            
                        } label: {
                            VStack{
                                Text("9")
                                    .bold()
                                Text("게시물")
                            }
                        }
                        Button {
                            
                        } label: {
                            VStack{
                                Text("2000")
                                    .bold()
                                Text("팔로워")
                            }
                        }
                        Button {
                        } label: {
                            VStack{
                                Text("2000")
                                    .bold()
                                Text("팔로잉")
                            }
                        }
                    }.padding()
                    .foregroundColor(.black)
                    HStack {
                        VStack(alignment:.leading){
                            Text("코몽")
                            Text("@qwe179")
                                .padding(10)
                                .frame(height: 30)
                                .background(Color(cgColor: UIColor(hexString: "#dededc").cgColor)).cornerRadius(10)
                        }.padding(.leading)
                            .padding(.bottom)
                        Spacer()
                    }.padding(.leading,10)
                    HStack {
                        Button{
                            print("11111")
                        } label:{
                            Text("프로필 편집")
                                .frame(width: 120,height:40)
                                .padding(.leading)
                                .padding(.trailing)
                                .overlay( /// apply a rounded border
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black, lineWidth: 2)
                                )
                        }
                        // .frame(width: 100)
                        Button{
                            print("11111")
                        } label:{
                            Text("프로필 공유")
                                .frame(width: 120,height:40)
                                .padding(.leading)
                                .padding(.trailing)
                            
                                .cornerRadius(10)
                                .overlay( /// apply a rounded border
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black, lineWidth: 2)
                                )
                        }
                     //   .frame(width: 100)
                        Button{
                            print("11111")
                        } label:{
                            Image(systemName: "person.badge.plus")
                                .padding(.leading)
                                .padding(.trailing)
                                .frame(width: 40,height:40)
                                .cornerRadius(10)
                                .overlay( /// apply a rounded border
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black, lineWidth: 2)
                                )
                        }
                    }.frame(width: UIScreen.main.bounds.width)
                        .foregroundColor(.black)
                    // MARK: - 탭바 버튼
                    
                    HStack() {
                        Button{
                            withAnimation() {
                                tabIndex = 1
                            }
                            print("11111")
                            
                        }label: {
                            Image(.chess)
                        }
                        .frame(width: UIScreen.main.bounds.width / CGFloat(3))
                        Button{
                            withAnimation {
                                tabIndex = 2
                            }
                            print("2222")
                        }label: {
                            Image(.video)
                        }
                        .frame(width: UIScreen.main.bounds.width / CGFloat(3))
                        Button{
                            withAnimation {
                                tabIndex = 3
                            }
                            print("3333")
                        }label: {
                            Image(.tagsIcon)
                        }
                        .frame(width: UIScreen.main.bounds.width / CGFloat(3))
                    }
                    // MARK: - 가로 슬라이더
                    HStack {
                        Rectangle()
                            .frame(width: UIScreen.main.bounds.width / CGFloat(3),
                                   height: 1)
                            .foregroundColor(.black)
                            .offset(x: UIScreen.main.bounds.width / CGFloat(3) * CGFloat(tabIndex-1))
                        //  .offset(x:-draggedOffset)
                        Spacer()
                    }
                    
                    Spacer()
                }//.frame(height:250)
                    .background(.clear)
                
                TabView(selection: $tabIndex) {
                    MyFeedView().tag(1)
                    MyReelsView().tag(2)
                    MyTagView().tag(3)
                }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .onPreferenceChange(SizePreferenceKey.self) { size in
                        tabViewHeight = size.height
                        print("tabViewHeight!!",tabViewHeight)
                    }
                    .frame(height: 1000)
                    .background(.white)
            }
            .refreshable {
                
            }
          //  .toolbarBackground(.white, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar) //필요
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    HStack {
                        Image(systemName: "lock")
                            .defualt()
                            .frame(width: 10)
                        Button(action:{}) {
                            Text("qwe179")
                                .bold()
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            Image(systemName: "chevron.down")
                                .defualt()
                                .frame(width: 10)
                        }.foregroundColor(.black)
                        
                    }
                    
                    
                }
                ToolbarItem {
                    HStack{
                        Image(.addrec2)
                        Spacer()
                        Image(.menu)
                    }.frame(width: 70)
                }
            }
        }.navigationTransition(.default, interactivity: .pan)
            .navigationBarColor(.white)
            .tint(.white)
        
        
    }
    

    
}


struct SizePreferenceKey: PreferenceKey{
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}


struct MyFeedView: View {
    
    @ObservedObject var myViewManager = MyViewManager()
    
    var columns: [GridItem] = [
           GridItem(.flexible(),spacing: 1),
           GridItem(.flexible(),spacing: 1),
           GridItem(.flexible(),spacing: 1)
       ]
    var body: some View {
        VStack {
            if let user = myViewManager.user {
                LazyVGrid(columns: columns, spacing: 3,content: {
                    ForEach(0 ..< user.imageURL.count, id: \.self) { index in
                        KFImage(user.imageURL[index])
                        //images[index]
                            .resizable()
                            //.aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width/3 - 2,height: 124)
                         
                    }
                })
            }
            Spacer()
        }

        
    }
    
}

struct MyReelsView: View {
    
    @ObservedObject var myViewManager = MyViewManager()
    @State private var isShowingDetail = false
    @State private var isPlaying = false
    @State var isAnimation = false
    
    
    var columns: [GridItem] = [
           GridItem(.flexible(),spacing: 1),
           GridItem(.flexible(),spacing: 1),
           GridItem(.flexible(),spacing: 1),
          // GridItem(.flexible(),spacing: 1)
       ]
    var body: some View {
        
        VStack {
            if let user = myViewManager.user {
                LazyVGrid(columns: columns, spacing: 3,content: {
                    ForEach(0 ..< user.videos.count, id: \.self) { index in
                        NavigationLink(destination: VideoView(player: AVPlayer(url: user.videos[index]))) {
                            VideoPlayer(player: AVPlayer(url: user.videos[index]))
                                .task {
                                    _ = AVPlayer(url: user.videos[index])
                                }
                                .aspectRatio(1/1, contentMode: .fit)
                                .transition(.scale)
                        }.foregroundColor(.black)
                    }
                })
            }
            Spacer()
        }
    }
    
}

struct VideoView: View {
    let player: AVPlayer
    
    @State private var offset: CGSize = .zero
     @State private var startLocation: CGPoint = .zero
     @State private var shouldDismiss: Bool = false
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VideoPlayer(player: player)
                .task {
                    _ = player
                }
                .aspectRatio(1/1, contentMode: .fit)
                .onAppear()
                .onDisappear(perform: {
                    player.pause()
                })
                .navigationTitle("릴스")
            
        }
                   
    }
        //드래그
//    var dragGesture: some Gesture {
//        DragGesture()
//            .onChanged { value in
//                if startLocation == .zero {
//                    startLocation = value.location
//                }
//                let gestureOffset = CGSize(width: value.location.x - startLocation.x,
//                                           height: value.location.y - startLocation.y)
//                offset = gestureOffset
//            }
//            .onEnded { value in
//                let gestureOffset = CGSize(width: value.location.x - startLocation.x,
//                                           height: value.location.y - startLocation.y)
//                if gestureOffset.width > 100 { // 이동 거리가 일정 수준 이상일 때
//                    shouldDismiss = true
//                } else {
//                    offset = .zero
//                    startLocation = .zero
//                }
//            }
//    }
}


struct MyTagView: View {
    
    @ObservedObject var myViewManager = MyViewManager()
    
    var columns: [GridItem] = [
           GridItem(.flexible(),spacing: 1),
           GridItem(.flexible(),spacing: 1),
           GridItem(.flexible(),spacing: 1)
       ]
    var body: some View {
        VStack {
            
            if let user = myViewManager.user {
                LazyVGrid(columns: columns, spacing: 3,content: {
                    ForEach(0 ..< user.imageURL.count, id: \.self) { index in
                        KFImage(user.imageURL[index])
                        //images[index]
                            .resizable()
                            //.aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width/3 - 2,height: 124)
                         
                    }
                })
            }
            Spacer()
        }

        
    }
    
}


#Preview {
    MyView()
}
