//
//  DmView.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/03/15.
//

import SwiftUI

struct DmView: View {
    @State private var searchText = ""
    @State private var showsCancelButton: Bool = false
    @Binding var detents: PresentationDetent
    @State var showView: Bool = false
    var body: some View {
        
        VStack {
            Button(action: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation {
                        showView.toggle()
                    }
                }
                
                withAnimation(.easeInOut(duration: 10)) {
                    //   showView.toggle()
                   // isLargeDetent.toggle()
                    detents = .large
                }
                
            }, label: {
                SearchBar(text: $searchText)
            })
            .fullScreenCover(isPresented: $showView, content: {
                FullDmView(detents: $detents, isPresented: $showView)
            })
            .transaction { transaction in
                transaction.disablesAnimations = true
                transaction.animation = .none
            }
            
//            .easyFullScreenCover(isPresented: $showView, content: {
//                Rectangle()
//            })
            
          
          
     
            
              //  .animation(.spring())
             
                    
            
//            Rectangle()
//                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
//                .onTapGesture {
//                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//                
//            }
        }.transition(.scale)
          

        
        
    }
}

struct FullDmView: View {
    @Binding var detents: PresentationDetent
    @Binding var isPresented: Bool
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""
    @State private var showsCancelButton: Bool = false
    @State private var isFullscreen: Bool = false
    @State private var showDetails = false
    
    var body: some View {
        VStack {
            HStack {
                SearchBar(text: $searchText)
                Button(action: {
                    withAnimation {
                        detents = .medium
                        isPresented = false
//                        isFullscreen.toggle()
                      
                    }
                  
                }, label: {
                    Text("취소")
                })
                
            }
//            if isFullscreen {
//                Rectangle().foregroundColor(.red)
//                    .transition(.slide)
//                    .animation(.easeInOut(duration: 5),value: isFullscreen)
//            }
            Rectangle().onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                
            }.foregroundColor(.blue)
        }
    }
}




// MARK: - 서치바

struct SearchBar: UIViewRepresentable {
    
    @Binding var text: String
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        init(text: Binding<String>) {
            _text = text
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
        return Coordinator(text: $text)
    }
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "검색"
        searchBar.showsCancelButton = false
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
        nextVC.modalPresentationStyle = .pageSheet
        if let sheetPresentationController = nextVC.sheetPresentationController {
            let multiplier = 0.6
            //얘를 클로저 밖에 선언해줘야 드래그 했을 때 크기가 일정하게 유지됨
            let viewSize =  nextVC.view.frame.height
            let fraction = UISheetPresentationController.Detent.custom { context in
                viewSize * multiplier //fraction 커스텀으로 생성
            }
            //왼쪽은 기본 크기, 오른쪽은 최대 크기.. .medium(), .large() 등 사용할 수 있다.
            sheetPresentationController.detents = [fraction,.large()]
            sheetPresentationController.delegate = context.coordinator
        }
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
    var preferredHeight: CGFloat = 40
}
//
//
//
//struct ContentView_Previews: PreviewProvider {
//    @Binding var isPresented: Bool
//  static var previews: some View {
//     
//      FullDmView(isPresented: isPresented)
////    ContentView()
//  }
//}
////
//#Preview {
////    DmView(detents: PresentationDetent.medium)
//    FullDmView(isPresented: false)
//}
