//
//  DmView.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/03/15.
//

import SwiftUI
import Kingfisher

struct DmView: View {
    
    @ObservedObject var dmManager = DmManager.shared
    @State private var searchText = ""
    @State private var showsCancelButton: Bool = false
    @State private var scale = 0.5
    @Binding var detents: PresentationDetent
    @State var showView: Bool = false
    @State var test: Bool = false
    @State var text: String = ""
    @State var showMessage = false
    @State var isEnable: Bool = false
    //    @State private var isSendDm: Bool = false
    
    
    
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack {
            VStack {
                Button(action: {
                    withAnimation() {
                        test.toggle()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation {
                            showView.toggle()
                        }
                    }
                    detents = .large
                    
                }, label: {
                    SearchBar(text: $searchText,isEnable: $isEnable)
                    
                })
                .padding(.top)
                .fullScreenCover(isPresented: $showView, content: {
                    FullDmView(detents: $detents, isPresented: $showView,test: $test, showMessage: $showMessage)
                    
                })
                .transaction { transaction in
                    transaction.disablesAnimations = true
                }
                // MARK: - dm 보낼 팔로워들 목록
                ScrollView {
                    LazyVGrid(columns: columns, content: {
                        ForEach(0..<dmManager.followers.count, id: \.self) { index in
                            if let profileImage = dmManager.followers[index].profile {
                                DmCollectionView(index: index, profileImage: profileImage, showMessage: $showMessage)
                            }
                        }
                    })
                }
            }.opacity(test ? 0 : 1)
            
            // MARK: - 하단 뷰
            if dmManager.receivers.count <= 0 && showMessage == false {
                BottomMenuView()
                .transition(.move(edge: .bottom))
                .frame(height: 100)
                .overlay(Divider().offset(y:-8), alignment: .top)
                .ignoresSafeArea()
                .onAppear(){
                    showMessage = false
                }
            }else if showMessage == true {
         
                VStack(spacing: 0){
                    Divider()
                    TextField("메시지 작성...", text: $text)
                        .padding()
                        .border(Color(uiColor: UIColor(hexString: "F0F0F0")))
                        .padding(.bottom)
                        .transition(.move(edge: .bottom))
                       
                    Button(action: {
                        
                    }) {
                        if dmManager.receivers.count == 1 {
                            Text("보내기")
                                
                        }else {
                            Text("따로 보내기")
                               
                        }
                    }
                    .frame(width: 300)
                    .padding()
                    .background(.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .transition(.move(edge: .bottom))
                }
                
                .transition(.move(edge: .bottom))
                // MARK: - VStack 디폴트 패딩(8) 빼는법~
                .padding(.top, -8)

                
            }
  
        }.onAppear() {
            //dm 리시버들 초기화..
            DmManager.shared.receivers.removeAll()
        }

        
    }
}
struct BottomMenuView: View {
    var rows: [GridItem] = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: rows, spacing: 0) {
                    Button(action: {}) {
                        VStack {
                            Image("1")
                                .icon()
                            Text("Threads")
                                .foregroundColor(.black)
                                .font(.system(size: 10))
                        }
                    }
                    .frame(width: 80)
                    .padding(.top)
                    .padding(.leading)
                    Button(action: {}) {
                        VStack {
                            Image("2")
                                .icon()
                            Text("스토리에 추가")
                                .foregroundColor(.black)
                                .font(.system(size: 10))
                        }
                    }
                    .frame(width: 80)
                    .padding(.top)
                    .padding(.leading)
                    Button(action: {}) {
                        VStack {
                            Image("3")
                                .icon()
                            Text("공유 대상 선택")
                                .foregroundColor(.black)
                                .font(.system(size: 10))
                        }
                    }
                    .frame(width: 80)
                    .padding(.top)
                    .padding(.leading)
                    Button(action: {}) {
                        VStack {
                            Image("4")
                                .icon()
                            Text("링크 복사")
                                .foregroundColor(.black)
                                .font(.system(size: 10))
                        }
                    }.frame(width: 80)
                    .padding(.top)
                    .padding(.leading)
                    Button(action: {}) {
                        VStack {
                            Image("5")
                                .icon()
                            Text("WhatsApp")
                                .foregroundColor(.black)
                                .font(.system(size: 10))
                        }
                    }
                    .frame(width: 80)
                    .padding(.top)
                    .padding(.leading)
                    Button(action: {}) {
                        VStack {
                            Image("6")
                                .icon()
                            Text("Facebook")
                                .foregroundColor(.black)
                                .font(.system(size: 10))
                        }
                    }
                    .frame(width: 80)
                    .padding(.top)
                    .padding(.leading)
                    Button(action: {}) {
                        VStack {
                            Image("7")
                                .icon()
                            Text("Messenger")
                                .foregroundColor(.black)
                                .font(.system(size: 10))
                        }
                    }
                    .frame(width: 80)
                    .padding(.top)
                    .padding(.leading)
                    Button(action: {}) {
                        VStack {
                            Image("8")
                                .icon()
                            Text("메세지")
                                .foregroundColor(.black)
                                .font(.system(size: 10))
                        }
                    }
                    .frame(width: 80)
                    .padding(.top)
                    .padding(.leading)
                    Button(action: {}) {
                        VStack {
                            Image("9")
                                .icon()
                            Text("X")
                                .foregroundColor(.black)
                                .font(.system(size: 10))
                        }
                    }
                    .frame(width: 80)
                    .padding(.top)
                    .padding(.leading)
                    Button(action: {}) {
                        VStack {
                            Image("10")
                                .icon()
                            Text("Snapchat")
                                .foregroundColor(.black)
                                .font(.system(size: 10))
                        }
                    }
                    .frame(width: 80)
                    .padding(.top)
                    .padding(.leading)
                }.onAppear() {
                    UIScrollView.appearance().bounces = false
                }
            }
        }
    }
}

struct FullDmView: View {
    @Binding var detents: PresentationDetent
    @Binding var isPresented: Bool
    @Binding var test: Bool
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""
    @State private var showsCancelButton: Bool = false
    @State private var isFullscreen: Bool = false
    @State private var showDetails = false
    @Binding var showMessage: Bool
    @State private var opacity: Double = 0
    @State var isEnable: Bool = true
    
    var body: some View {
        VStack {
            HStack {
                SearchBar(text: $searchText,isEnable : $isEnable)
                Button(action: {
                    withAnimation {
                        detents = .medium
                        isPresented = false
                        test = false
                        //                        isFullscreen.toggle()
                        
                    }

                    
                }, label: {
                    Text("취소")
                })
                
            }
            List{
                ForEach(0..<DmManager.shared.followers.count, id: \.self) { index in
                    if let profileImage = DmManager.shared.followers[index].profile {
                      //  DmListView(index: index, profileImage: profileImage)
                        DmListView(index: index, profileImage: profileImage, detents: $detents, isPresented: $isPresented, test: $test)
                      //    .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)
                        // MARK: - 리스트 선택시 백그라운드 색깔 없애는거.. 찾기힘들었다.
                            .listRowBackground(Color.clear)
                    }
                }
            }
            .onAppear(){
                UIScrollView.appearance().bounces = true
                
                // MARK: - 리프레쉬가 안에 들어가서.. 아무것도없는뷰를 커스텀뷰로 설정해줌..
                
                UIRefreshControl.appearance().tintColor = .clear
                UIRefreshControl.appearance().addSubview(SingletonView.shared)
                
            }
            .refreshable {
                
            }
            
            
            // MARK: - onTapGesture 넣으면.. 리스트의 로우 선택하는데 오래누르고있어야함... 타임아웃있는것같음
            
            //            .onTapGesture {
            //                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            //
            //            }
        }.onAppear() {
            withAnimation {
                self.opacity = 1
            }
            
        }
        .opacity(opacity)
    }
}

// MARK: - 뷰 분리하면 뱃지 이미지 각각 적용 가능.. 인스턴스가 다르니까??
struct DmListView: View {
    var index: Int
    var profileImage: URL
    @Binding var detents: PresentationDetent
    @Binding var isPresented: Bool
    @Binding var test: Bool
    @State var isSelected: Bool = false

    var body: some View {
        
        Button(action: {
            isSelected.toggle()
            DmManager.shared.addReciever(DmManager.shared.followers[index])
            
            withAnimation {
                detents = .medium
                isPresented = false
                test = false
                //                        isFullscreen.toggle()
                
            }
        }) {
            HStack {
                KFImage(profileImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .frame(width: 40, height: 40)
                
                VStack(alignment: .leading) {
                    Text(DmManager.shared.followers[index].name)
                        .foregroundColor(.black)
                    Text(DmManager.shared.followers[index].id)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                }else {
                    Image(systemName: "circle")
                        .foregroundColor(.gray)
                }
            }
        }
        .onAppear(){
            if DmManager.shared.receivers.contains(DmManager.shared.followers[index]) {
                isSelected = true
            }
        }

        
        //  Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
        
    }
}

struct DmCollectionView: View {
    var index:Int
    var profileImage:URL
    @State private var isSendDm: Bool = false
    @Binding var showMessage: Bool
    var body: some View {
        VStack {
            Button(action: {
                isSendDm.toggle()
                if isSendDm {
                    //체크 켜지면 dm 받을사람 리스트에 추가
                    DmManager.shared.addReciever(DmManager.shared.followers[index])
                    print("receiverCnt:\(DmManager.shared.receivers.count)")
                    withAnimation(.easeOut(duration: 0.2)) {
                        showMessage = true
                    }
           
                }else {
                    //체크 꺼지면 dm 받을사람 리스트에서 제거
                    DmManager.shared.removeReciever(DmManager.shared.followers[index])
                    print("receiverCnt:\(DmManager.shared.receivers.count)")
                    if DmManager.shared.receivers.count == 0 {
                        withAnimation(.easeOut(duration: 0.2)) {
                            showMessage = false
                        }
                    }
                }
            }){
                VStack {
                    ZStack {
                        KFImage(profileImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .frame(width: 80, height: 80)
                        if isSendDm {
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .overlay{
                                    Circle().stroke(.white, lineWidth: 2)
                                }
                                .offset(x:30,y:30)
                                .foregroundColor(.black)
      
                        }
                    }
                    Text(DmManager.shared.followers[index].name)
                        .foregroundColor(.black)
                }
            }
        }.onReceive(DmManager.shared.$receivers, perform: { _ in
            if DmManager.shared.receivers.contains(DmManager.shared.followers[index]) {
                isSendDm = true
            }
        })
        .transaction { transaction in
            transaction.disablesAnimations = true
        }

    }
}




// MARK: - 서치바

struct SearchBar: UIViewRepresentable {
    
    @Binding var text: String
    @Binding var isEnable: Bool
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        @Binding var isEnable: Bool
        init(text: Binding<String>,isEnable: Binding<Bool>) {
            _text = text
            _isEnable = isEnable
        }
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//            searchBar.setShowsCancelButton(true, animated: true)
            //searchBar.showsCancelButton = false
        }
        
        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//            print(#function)
//            searchBar.setShowsCancelButton(false, animated: true)
        }
        func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
//            searchBar.setShowsCancelButton(false, animated: true)
//            searchBar.showsCancelButton = false
            return true
        }
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//            searchBar.showsCancelButton = false
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            
        }
        
    }
    
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text,isEnable: $isEnable)
    }
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "검색"
        searchBar.showsCancelButton = false
        if context.coordinator.isEnable == false {
            searchBar.isUserInteractionEnabled = false
        }
    
        //서치바 취소버튼 문구 바꾸기!!
        searchBar.setValue("취소", forKey: "cancelButtonText")
    
        return searchBar
    }
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
    
    
}


// MARK: - 모달..컨트롤러..근데안씀

struct ViewControllerRepresentation: UIViewControllerRepresentable {
    typealias Coordinator = DmViewCoordinator
    
    
    func makeUIViewController(context: Context) -> UIViewController {
        let nextVC = UIViewController()
        nextVC.modalPresentationStyle = .fullScreen
//        nextVC.modalPresentationStyle = .pageSheet
//        if let sheetPresentationController = nextVC.sheetPresentationController {
//            let multiplier = 0.6
//            //얘를 클로저 밖에 선언해줘야 드래그 했을 때 크기가 일정하게 유지됨
//            let viewSize =  nextVC.view.frame.height
//            let fraction = UISheetPresentationController.Detent.custom { context in
//                viewSize * multiplier //fraction 커스텀으로 생성
//            }
//            //왼쪽은 기본 크기, 오른쪽은 최대 크기.. .medium(), .large() 등 사용할 수 있다.
//            sheetPresentationController.detents = [fraction,.large()]
//            sheetPresentationController.delegate = context.coordinator
//        }
        return nextVC
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = UIViewController
    
    func makeCoordinator() -> ViewControllerRepresentation.Coordinator {
        return DmViewCoordinator()
    }
    
    
}

class DmViewCoordinator: NSObject, UISheetPresentationControllerDelegate {
   // var preferredHeight: CGFloat = 40
}
//
//
//
//struct ContentView_Previews: PreviewProvider {
//    @State var showView: Bool = false
//    @State var detents: PresentationDetent = .medium
//  static var previews: some View {
//     
//      DmView(detents: $detents)
////    ContentView()
//  }
//}
////
//#Preview {
////    DmView(detents: PresentationDetent.medium)
//    FullDmView(isPresented: false)
//}
