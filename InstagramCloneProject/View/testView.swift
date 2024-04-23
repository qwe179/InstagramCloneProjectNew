//
//  testView.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/03/03.
//

import SwiftUI
//import SwiftUIIntrospect

struct ContentView2: View {
    @StateObject private var viewModel: ViewModel = ViewModel()
    @State private var scrollOffet: CGFloat = 59
    @State private var scrollOffetArray: [CGFloat] = [0,0,0]
    @State private var tabIndex = 1
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack(spacing:60) {
                        
                        Button {
                            
                        } label: {
                            Image(.chichi)
                                .defualt()
                                .clipShape(Circle())
                                .frame(width: 50)
                        }
                       
                        Button {
                            
                        } label: {
                            VStack{
                                Text("9")
                                Text("게시물")
                            }
                        }
                        Button {
                            
                        } label: {
                            VStack{
                                Text("2000")
                                Text("팔로워")
                            }
                        }
                        Button {
                            
                        } label: {
                            VStack{
                                Text("2000")
                                Text("팔로잉")
                            }
                        }
                    }.padding()
                    HStack {
                        VStack(alignment:.leading){
                            Text("코몽")
                            Text("@qwe179")
                        }.padding(.leading)
                        Spacer()
                    }
                    HStack {
                        Button{
                            print("11111")
                        } label:{
                            Text("프로필 편집")
                                .padding()
                            
                                .cornerRadius(10)
                                .overlay( /// apply a rounded border
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black, lineWidth: 2)
                                )
                        }
                        // .frame(minWidth: 100)
                        Button{
                            print("11111")
                        } label:{
                            Text("프로필 공유")
                                .padding()
                            
                                .cornerRadius(10)
                                .overlay( /// apply a rounded border
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black, lineWidth: 2)
                                )
                        }
                        Button{
                            print("11111")
                        } label:{
                            Image(systemName: "person.badge.plus")
                                .padding()
                            
                                .cornerRadius(10)
                                .overlay( /// apply a rounded border
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black, lineWidth: 2)
                                )
                        }
                    }
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
                            print("11111")
                        }label: {
                            Image(.video)
                        }
                        .frame(width: UIScreen.main.bounds.width / CGFloat(3))
                        Button{
                            withAnimation {
                                tabIndex = 3
                            }
                            print("11111")
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
                }.frame(height:250)
                    .background(.clear)
                    .offset(y: -333 + self.scrollOffet)
                
                    .zIndex(2)
                //     .offset(y: -320 + self.scrollOffet)
                TabView(selection: $tabIndex) {
                    
                    //  ScrollViewReader { proxy in
                    ScrollView{
                        scrollObservableView
                        
                        VStack {
                            Rectangle().frame(width:UIScreen.main.bounds.width ,height: 240).foregroundColor(.white)
                                .gesture(
                                    DragGesture().onChanged { _ in
                                        // 특정 페이지의 넘김을 무시하도록 제스처 동작 무시
                                    }
                                )
                            MyFeedView()
                        }
                        
                    }.refreshable {
                        
                    }
//                    .introspect(.scrollView, on: .iOS(.v13, .v14, .v15, .v16, .v17)) { sv in
//                        sv.verticalScrollIndicatorInsets.top = 400
//                        
//                    }
                    .onPreferenceChange(ScrollOffsetKey.self) {
                        v1 in
                        print("v1:\(v1)")
                        self.scrollOffet = v1
                        self.scrollOffetArray[0] = v1
                    }
                    .onAppear(){
                        self.scrollOffet = self.scrollOffetArray[0]
                        if self.scrollOffetArray[1] < -150{
                            self.scrollOffet = -150
                        }
                    }
                    .tag(1)

                    ScrollView{
                        scrollObservableView
                        VStack {
                            Rectangle().frame(width:UIScreen.main.bounds.width ,height: 240).foregroundColor(.white)
                                .gesture(
                                    DragGesture().onChanged { _ in
                                        // 특정 페이지의 넘김을 무시하도록 제스처 동작 무시
                                    }
                                )
                            MyReelsView()
                         
                        }
                        
                    }.refreshable {
                        
                    }
//                    .introspect(.scrollView, on: .iOS(.v13, .v14, .v15, .v16, .v17)) { sv in
//                        sv.verticalScrollIndicatorInsets.top = 400
//                        
//                    }
                    .onPreferenceChange(ScrollOffsetKey.self) {
                        v1 in
                        print("v2:\(v1)")
                        self.scrollOffet = v1
                        self.scrollOffetArray[1] = v1
                    }
                    .onAppear(){
                        self.scrollOffet = self.scrollOffetArray[1]
                        if self.scrollOffetArray[0] < -150 || self.scrollOffetArray[2] < -150{
                            self.scrollOffet = -150
                        }
                    }
                    .tag(2)
                    
                    ScrollView{
                        scrollObservableView
                        VStack {
                            Rectangle().frame(width:UIScreen.main.bounds.width ,height: 240).foregroundColor(.white)
                                .gesture(
                                    DragGesture().onChanged { _ in
                                        // 특정 페이지의 넘김을 무시하도록 제스처 동작 무시
                                    }
                                )
                            MyTagView()
                        }
                        
                    }.refreshable {
                        
                    }
//                    .introspect(.scrollView, on: .iOS(.v13, .v14, .v15, .v16, .v17)) { sv in
//                        sv.verticalScrollIndicatorInsets.top = 400
//                        
//                    }
                    .onPreferenceChange(ScrollOffsetKey.self) {
                        v1 in
                        print("v3:\(v1)")
                        self.scrollOffet = v1
                        self.scrollOffetArray[2] = v1
                    }
                    .onAppear(){
                        self.scrollOffet = self.scrollOffetArray[2]
                        if self.scrollOffetArray[1] < -150 {
                            self.scrollOffet = -150
                        }
                    }
                    .tag(3)
                    // }
                }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .background(.white)
                    .zIndex(1)
                
            }
            .toolbarBackground(.white, for: .navigationBar)
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
struct ScrollViewWithContentView<Content: View>: UIViewRepresentable {
    let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        let hostingController = UIHostingController(rootView: content())
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(hostingController.view)
        
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            hostingController.view.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        // Update UI
        uiView.scrollIndicatorInsets = UIEdgeInsets(top: 400, left: 0, bottom: 0, right: 0)
    }
}



#Preview {
    ContentView2()
}
