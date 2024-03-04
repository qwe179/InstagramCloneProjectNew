//
//  HomeView.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/02/28.
//

import SwiftUI
import BriefPagingControl
import Kingfisher
@_spi(Advanced) import SwiftUIIntrospect


struct FeedView: View {
    @StateObject private var viewModel: ViewModel = ViewModel()
    @State private var isFadeOut = false
    @State private var fadeOutRatio:CGFloat = 1
    @State private var offsetFlag = false

    
    init() {
        // MARK: - 스크롤 튕기는거 off
     //  UIScrollView.appearance().bounces = false
    }
    var body: some View {
        VStack {
            ZStack {
                
                
                List{
                    Color.clear
                        .frame(height: 50)
                    
                    ZStack {
                        scrollObservableView
                        ExtractedView().listRowInsets(EdgeInsets()).listRowSeparator(.hidden)
                    }.listRowInsets(EdgeInsets())
                    
                    ListView()
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                }.listStyle(PlainListStyle())
                    .onPreferenceChange(ScrollOffsetKey.self) {
                        viewModel.setOffset($0)
                        
                        if  viewModel.direct == .up {
                            if viewModel.originOffset - viewModel.offset < 0 {
                                viewModel.originOffset = viewModel.offset
                            }
                        }else if viewModel.direct == .down {
                            if viewModel.originOffset - viewModel.offset > 100 {
                                viewModel.originOffset = viewModel.offset + 100
                            }
                                //if viewModel.or
  

                        }
                        if viewModel.originOffset > 141 {
                            viewModel.originOffset = 141
                            viewModel.offset = 141
                        }
                        
                        if viewModel.offset == viewModel.originOffset {
                            self.fadeOutRatio = 1
      
                        }
//                        if viewModel.offset < viewModel.originOffset {
//                           
//                            //0.1
//                        }
                        self.fadeOutRatio = (viewModel.offset - viewModel.originOffset) / 50 + 1
                        //self.fadeOutRatio =  (viewModel.offset - viewModel.originOffset)
                        
                        
                    }
                // }
                //                .introspect(.list, on: .iOS(.v16, .v17)) { collectionView in
                //                    collectionView.backgroundView = UIView()
                //                    collectionView.subviews.dropFirst(1).first?.backgroundColor = .cyan
                //                    collectionView.bounces = true
                //                }
                    .background(.clear)
                
                VStack {
                    HStack() {
                        Image("camera")
                        Spacer()
                        Image("instagramLogoWhite").resizable().aspectRatio(contentMode: .fit)
                            .frame(width: 105)
                        Spacer()
                        Image("dm")
                    }
                    .padding(.top,40)
                    .padding(.leading)
                    .padding(.trailing)
                    .frame(width: UIScreen.main.bounds.width,height: 90)
                    
                    .background(.white)
                   
                    //            Divider()
                    Spacer()
                }//왜 값이 30이냐면...나도모름
                //.position(x: UIScreen.main.bounds.width / 2, y: 0)
                .ignoresSafeArea()
                .offset(y: {
                    if viewModel.offset - viewModel.originOffset > 0 {
                        return 0 //최대 0
                    }else {
                        return viewModel.offset - viewModel.originOffset} }())
            
             //   .offset(y:viewModel.offset - viewModel.originOffset < 32 ?  viewModel.offset - viewModel.originOffset-32 : 0 )
                .opacity(fadeOutRatio)
                
            }
 
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
 
    @ObservedObject var urlImageLoader = URLImageLoader()
    @State var offset:CGFloat = 0
    @State var tabIndex = 0
    @State private var temp = 0
    let ImageUrls:[URL] = [URL(string: "https://randomuser.me/api/portraits/men/50.jpg")!,
                           URL(string: "https://mblogthumb-phinf.pstatic.net/MjAxOTA1MDdfMjc1/MDAxNTU3MjE5MTgzMjY5.DQwQpQFlVNGMsF0xgb8CnD0ZxU6eUcXt7gfBPqinEkMg.NoSOhwRQP5FlCP3UIjaGonLyXc-gphDAsaZvdK0au1sg.PNG.cine_play/%ED%94%BC%EC%B9%B4%EC%B8%842.png?type=w800")! ]
    private let images = ["test", "chichi","test2", "test3", "test4", "test5"]
    var body: some View {
        VStack {
            HStack {
                KFImage(ImageUrls[0])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32,height: 32)
                    .clipShape(Circle())
                VStack(alignment:.leading,spacing: 0){
                    Text("Comong")
                    HStack {
                        Text("Incheon, korea")
                        Image("checkIcon")
                    }
                    
                }
                Spacer()
                Image(.moreIcon)
            }.padding()

            VStack {
                TabView(selection: $tabIndex){
                        ForEach(ImageUrls.indices,id: \.self){ index in
                                KFImage(ImageUrls[index])
                            
//                                Image(images[index])
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(minHeight: 2000)
                               
                        }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode:.never))
                HStack{
                    HStack {
                        Image(.heart)
                        Image(.comment)
                        Image(.dm)
                    }
                    Spacer()
                    Image(.save)
                }.padding()
                .overlay {
                    BriefPagingControl(numberOfPages: ImageUrls.count, currentPage: $tabIndex) { config in
                        config.indicatorSize = 10
                        config.spacing = 10
                        config.currentIndicatorColor = .blue
                        config.indicatorColor = .black.opacity(0.15)
                       // config.numberOfMainIndicators = .five
                        config.hidesForSinglePage = true
                        config.animation = .snappy
                    }
                }
            }.frame(minHeight: 400,maxHeight: 500)
            //.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            
        }.onAppear{
        }
    }
}




#Preview {
    FeedView()
}

struct ExtractedView: View {
    let data = (1...20).map { $0 }
    var columns: [GridItem] = [
           GridItem(.flexible(minimum: 10,maximum: 80))
       ]
    var body: some View {
        VStack {
//            VStack {
//                HStack() {
//                    Image("camera")
//                    Spacer()
//                    Image("instagramLogoWhite").resizable().aspectRatio(contentMode: .fit)
//                        .frame(width: 105)
//                    Spacer()
//                    Image("dm")
//                }
//                .padding(.top)
//                .padding(.leading)
//                .padding(.trailing)
//            Divider()
//            }
     
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: columns, spacing: 20) {
                    ForEach(data, id: \.self) { item in
                        UserView(title: "\(item)")
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
