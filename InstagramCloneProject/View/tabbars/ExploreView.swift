//
//  exploreView.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/02/28.
//

import SwiftUI
import SwiftUIIntrospect
import Kingfisher
import NukeUI

struct ExploreView: View {
    @StateObject var viewModel = ViewModel()
    @StateObject var exploreViewDataManager = ExploreViewDataManager()
    
    @State private var searchText = ""
    @State var showView: Bool = true
    @State var isEditing: Bool = false
    @State var showsCancelButton: Bool = true
    @State var offset: CGFloat = 100

    private let countries = [
        "Afghanistan", "Albania", "Algeria", "Andorra", "Angola", "Antigua and Barbuda", "Argentina", "Armenia", "Australia", "Austria"
    ]

    
    private var searchResults : [String] {
        searchText.isEmpty ? countries : countries.filter { $0.contains(searchText) }
    }
    
    var body: some View {
        VStack {
            
            
            NavigationStack {

                ZStack {
                    VStack {
                       /* SearchBar(text: $searchText, isEnable: $showView,isEditing: $isEditing ,isCancelButton: $showsCancelButton)
                            .padding(.leading)
                            .padding(.trailing)
                            .background(.white)
                        .offset(y: offset)
                        .frame(height: 40)*/
                        HStack{
                            //검색창을 받을수있는 택스트필드
                            TextField("검색" , text : self.$searchText)
                                .padding(10)
                                .padding(.leading,30)
                                .background(Color(.systemGray6))
                                .cornerRadius(15)
                                .overlay(
                                    HStack{
                                        Image(systemName: "magnifyingglass")
                                            .foregroundColor(Color(.gray))
                                            .padding()
                                        Spacer()
                                    }
                                ).onTapGesture {
                                    self.isEditing = true
                                    
                                }
                            if self.isEditing{
                                Button(action : {
                                    withAnimation(.default) {
                                        self.isEditing = false
                                    }
                                    
                                    self.searchText = ""
                                    //키보드에서 입력을 끝내게하는 코드
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                }){
                                    Text("취소")
                                        .foregroundColor(Color(.black))
                                        .padding(.trailing)
                                }   .transition(.move(edge: .trailing))
                            }
                        }.padding(.bottom)
                        .background(.white)
                        .offset(y: offset)
                        .frame(height: 40)
                        Spacer()
                    }.background(.clear)
                        .zIndex(3)
                    
                    if self.isEditing{
                        ZStack {
                            Color.white
                                .ignoresSafeArea()
                            
                            List((0..<20).filter({"\($0)".contains(self.searchText) || self.searchText.isEmpty}), id : \.self){ i in
                            
                                HStack {
                                    LazyImage(url: URL(string:"https://media.istockphoto.com/id/157681198/ko/%EC%82%AC%EC%A7%84/%EB%AF%BC%EB%93%A4%EB%A0%88-seed.jpg?s=612x612&w=0&k=20&c=BtRA1Q24ICmHkRb6HS0tInJ1JQKAEiTm0dC1tBtfs5s="))
                                    { state in
                                        if let image = state.image {
                                            image.resizable().aspectRatio(contentMode: .fill)
                                        } else if state.error != nil {
                                            Color.clear // Indicates an error
                                        } else {
                                            Color.clear // Acts as a placeholder
                                        }
                                    }
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(Circle())
                                    .overlay {
                                        Circle().stroke(  LinearGradient(gradient: Gradient(colors: [.red, .yellow, .purple]), startPoint: .bottomLeading, endPoint: .topTrailing), lineWidth: 3)
                                    }
                                    .frame(width:70,height:70)
                                    .listRowInsets(EdgeInsets())
                                    
                                    VStack {
                                        Text("id\(i)")
                                        Text("name\(i)")
                                    }.listRowInsets(EdgeInsets())
                                    Spacer()
                                    
                                }.listRowSeparator(.hidden)
                                    .listRowInsets(EdgeInsets())
                                    //.background(.red)
                            }.listRowInsets(EdgeInsets())
                                .listStyle(PlainListStyle())
                            
                            .offset(y:49)
                 
                        }.zIndex(2)
                    }
                
                 
                    GeometryReader { reader in
                        
                        ScrollView {
                            scrollObservableView
                            Color.clear.frame(height: 60)
                            ExploreGrid(vm: exploreViewDataManager, spacing: 2, reader: reader)
                            
                            
                            // List(searchResults, id: \.self) { country in
                            //   Text(country)
                            //}
                        }.background(.clear)
                            .introspect(.scrollView, on: .iOS(.v13, .v14, .v15, .v16, .v17)) { sv in
                                sv.verticalScrollIndicatorInsets.top = 80
                                sv.refreshControl?.bounds = CGRectMake(0, -50, 0, 0)
                                
                            }
                            .onPreferenceChange(ScrollOffsetKey.self) {
                                v1 in
                                print("v1:",v1)
                                print("self.offset:",self.offset)
                                viewModel.setOffset(v1)
                                //1.현재 서치뷰가 화면밖에있고, 스크롤 올리는중
                                if self.offset == -100 , viewModel.direct == .up{
                                    print("현재 서치뷰가 화면밖에있고, 스크롤 올리는중")
                                    let changedOffset = v1 - viewModel.originOffset
                                    print("바뀔 오프셋:",changedOffset)
                                    self.offset = min(max(-100, changedOffset), 0)
                                }
                                //2.현재 서치뷰가 화면밖에있고, 스크롤 내리는중
                                if self.offset == -100 , viewModel.direct == .down{
                                    print("현재 서치뷰가 화면밖에있고, 스크롤 내리는중")
                                    viewModel.originOffset = v1 + 99
                                    let changedOffset = v1 - viewModel.originOffset
                                    print("바뀔 오프셋:",changedOffset)
                                    self.offset = min(max(-100, changedOffset), 0)
                                }
                                //3.현재 서치뷰가 화면안에있고, 스크롤 올리는중
                                if self.offset > -100 , viewModel.direct == .up{
                                    let changedOffset = v1 - viewModel.originOffset
                                    self.offset = min(max(-100, changedOffset), 0)
                                }
                                //3.현재 서치뷰가 화면안에있고, 스크롤 내리는중
                                if self.offset > -100 , viewModel.direct == .down{
                                    let changedOffset = v1 - viewModel.originOffset
                                    self.offset = min(max(-100, changedOffset), 0)
                                }
                                //4.현재 서치뷰가 원위치에 있음
                                if self.offset == 0 ,v1 < 47 {
                                    viewModel.originOffset = v1
                                    let changedOffset = v1 - viewModel.originOffset
                                    self.offset = min(max(-100, changedOffset), 0)
                                }
                            }
                            .refreshable {
                                do {
                                    try await Task.sleep(nanoseconds: 1_000_000_000)
                                } catch {
                                    
                                }
                            }
                            .onAppear {
                                self.offset = 0
                                print("onApper!!!!")
                            }
                    }
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
                
                .onAppear { // 나타날때 뷰의 최초위치를 저장하는 로직
                    viewModel.setOriginOffset(offsetY)
                    print("뷰 최초 오프셋",offsetY)
                }
    
        }
        .frame(height: 0)
    }
}


private struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()

    }
}

#Preview {
    ExploreView()
}
