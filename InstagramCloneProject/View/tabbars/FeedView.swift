//
//  HomeView.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/02/28.
//

import SwiftUI
import BriefPagingControl
import Kingfisher
import SwiftUIModal
//@_spi(Advanced) import SwiftUIIntrospect


struct FeedView: View {
    @ObservedObject var storyManager = StoryManager.shared
    @StateObject private var viewModel: ViewModel = ViewModel()
    @State private var isFadeOut = false
    @State private var fadeOutRatio:CGFloat = 1
    @ObservedObject var feedManager = FeedManager.shared
    @State private var hideNavBar:Bool = true
    @State private var showCameraView = false
    @State private var selectedImage: UIImage = UIImage(named: "chichi")!
    init() {
        // MARK: - 스크롤 튕기는거 off
        //  UIScrollView.appearance().bounces = false
    }
    var body: some View {
        NavigationView{
            VStack {
                List{
                    ZStack {
                        scrollObservableView
                        CollectionView().listRowInsets(EdgeInsets()).listRowSeparator(.hidden)
                    }.listRowInsets(EdgeInsets())
                    // MARK: - 인간수만큼 생성
                    // imageUrls = one.
                    ForEach(0...feedManager.feedCounts - 1, id: \.self) { count in
                        //  ListView(imageUrls: feedManager.feed[count].imageURLs.compactMap { $0 })
                        ListView(imageUrls: feedManager.feed[count].imageURLs.compactMap { $0 }, user: feedManager.feed[count])
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)
                    }
                    
                }.listStyle(PlainListStyle())
                
                    .refreshable {
                        //NotificationCenter.default.post(name: .customEvent, object: nil)
                        do {
                            try await Task.sleep(nanoseconds: 1_000_000_000)
                            storyManager.fetchData()
                        } catch {
                            
                        }
                    }
                    .onPreferenceChange(ScrollOffsetKey.self) {
                        _ in
                    }
                    .background(.clear)
                
            }
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    VStack {
                        HStack() {
                            Button(action: {
                                self.showCameraView.toggle()
                            }){
                                Image("camera")
                            }
                            // MARK: - 풀스크린하려면 .fullScreenCover 해야함.. .sheet 말고..
                            
                            .fullScreenCover(isPresented: $showCameraView, content: {
                                ImagePicker(image: $selectedImage, isActive: $showCameraView)
                                    .edgesIgnoringSafeArea(.all)
                            })
                            
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
    }
    
    
    private var scrollObservableView: some View {
        
        GeometryReader { proxy in
            let offsetY = proxy.frame(in: .global).origin.y
            Color.clear
                .preference(
                    key: ScrollOffsetKey.self,
                    value: offsetY
                )
                .onAppear {
                    viewModel.setOriginOffset(offsetY)
                }
        }
        .frame(height: 0)
    }
    
    struct ScrollOffsetKey: PreferenceKey {
        static var defaultValue: CGFloat = .zero
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            // MARK: - 내부적으로 뭔가 잘못되있는거 수정함
            
            if value == 0 {
                value += nextValue()
            }
        }
    }
}

struct UserView: View {
    let title: String
    var body: some View {
        VStack {
            VStack {
                Image("chichi")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .overlay{
                        Circle().stroke(.white, lineWidth: 8)
                    }
                    .overlay {
                        Circle().stroke(  LinearGradient(gradient: Gradient(colors: [.red, .yellow, .purple]), startPoint: .bottomLeading, endPoint: .topTrailing), lineWidth: 3)
                    }
            }
            .frame(height: 62)
            VStack {
                Text(title)
            }
            .frame(height: 14)
        }
     
        
    }
}



struct ListView: View {
 
  //  @ObservedObject var urlImageLoader = URLImageLoader()
    @State private var isModalPresented = false
    @State private var isDmPressed = false
    @State private var isHeartPressed = false
    @State private var isSavePressed = false
    @State private var settingsDetent = false
    @State private var detents: PresentationDetent = .medium
    @State private var temp = 0
    @State var offset:CGFloat = 0
    @State var tabIndex = 0
    //@State var one: SomeOne
    @State var imageUrls: [URL]
    @State var user: SomeOne
    private let images = ["test", "chichi","test2", "test3", "test4", "test5"]
    var body: some View {
        VStack {
            HStack {
                KFImage(user.profilePhoto)
                    .cancelOnDisappear(true) //셀이 화면 밖에 있을 때는 다운로드 취소
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32,height: 32)
                    .clipShape(Circle())
                VStack(alignment:.leading,spacing: 0){
                    Text(user.name)
                    HStack {
                        Text(user.location)
                        Image("checkIcon")
                    }
                }
                Spacer()
                Image(.moreIcon)
            }.padding()
            VStack {
                TabView(selection: $tabIndex){
                        ForEach(imageUrls.indices,id: \.self){ index in
                                KFImage(imageUrls[index])
                                    .cancelOnDisappear(true) //셀이 화면 밖에 있을 때는 다운로드 취소
//                                Image(images[index])
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(minHeight: 400)
                               
                        }
                }.frame(minHeight: 400)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode:.never))
                HStack{
                    
                    Button(action: {
                        isHeartPressed.toggle()
                    }){
                       // Image(.heart)
                        Image(isHeartPressed ? "heart.fill" : "heart")
                            .frame(width: 25,height: 20)
                    }
                    Button(action: {
                        isModalPresented.toggle()
                    }){
                        Image(.comment)
                    }
                    .bottomSheet(isPresented: $isModalPresented) {
                        // TODO: - 나중에 게시물 아이디라던지 값 전달해서 쿼리로 조회.. 현재는없음
                        CommentView()
                            .frame(maxHeight: UIScreen.main.bounds.height)
                            .cornerRadius(10)
                    }
                    .bottomSheetConfiguration(
                        .init(
                            dismissRatio: 0.5,
                            maxOverDrag: 0,
                            background: {  AnyView(RoundedRectangle(cornerRadius: 10).fill(Color.white)) },
                            dim: { Color.black.opacity(0.6) },
                            indicator: {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.gray)
                                    .frame(width: 50, height: 5).padding()
                            }
                        )
                    )
                    Button(action: {
                        isDmPressed.toggle()
                    }){
                        Image(.dm)
                    }
                    .sheet(isPresented: $isDmPressed, content: {
                        DmView(detents: $detents)
                            .presentationDetents([.medium,.large], selection: $detents)
                            
                        //DmView()
                            .cornerRadius(10)
                           // .presentationDetents([.medium,.large])
                          //  .presentationDetents(isLargeDetent ? [.large,.large] : [.medium,.large])
                            

                    })
              
                    Spacer()
                    Button(action: { 
                        isSavePressed.toggle()
                    }){
                        Image(isSavePressed ? "save.fill" : "Save")
                            .frame(width: 10,height: 10)
                       // Image(.save)
                        //Image("Save")
                    }
                }.padding(.leading)
                 .padding(.trailing)
                 .buttonStyle(PlainButtonStyle())
                .overlay {
                    BriefPagingControl(numberOfPages: imageUrls.count, currentPage: $tabIndex) { config in
                        config.indicatorSize = 10
                        config.spacing = 10
                        config.currentIndicatorColor = .blue
                        config.indicatorColor = .black.opacity(0.15)
                       // config.numberOfMainIndicators = .five
                        config.hidesForSinglePage = true
                        config.animation = .snappy
                    }
                }
                HStack{
                    Text("좋아요")
                    Text("\(user.numberOfLike)개")
                    
                    Spacer()
                }.padding(.leading)
                HStack{
                    Text(user.name)
                    Text(user.contents)
                    Spacer()
                }.padding(.leading)
            }
            Divider()
            
        }.onAppear{
           // imageUrls = one.imageURLs.compactMap { $0 }
        }
    }
}




#Preview {
    FeedView()
}

struct CollectionView: View {
    @ObservedObject var storyManager = StoryManager.shared
    let data = (1...20).map { $0 }
    var columns: [GridItem] = [
           GridItem(.flexible(minimum: 10,maximum: 80))
       ]
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: columns, spacing: 20) {
                    ForEach(0..<storyManager.storyCount, id: \.self) { index in
                        //UserView(title: "\(item)")
                        VStack {
                            VStack {
                                KFImage(storyManager.stories[index].profilePhoto)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(Circle())
                                    .overlay{
                                        Circle().stroke(.white, lineWidth: 8)
                                    }
                                    .overlay {
                                        Circle().stroke(  LinearGradient(gradient: Gradient(colors: [.red, .yellow, .purple]), startPoint: .bottomLeading, endPoint: .topTrailing), lineWidth: 3)
                                    }
                            }
                            .frame(width: 62, height: 62)
                            VStack {
                                Text(storyManager.stories[index].name)
                            }
                            .frame(height: 14)
                        }
                        
                        
                    }
                }
                .padding()
                .frame(height: 100)
             
            }
            Divider()
        }       .onAppear {
    
          //  UIScrollView.appearance().bounces = false
        
        }
  
    }
}
