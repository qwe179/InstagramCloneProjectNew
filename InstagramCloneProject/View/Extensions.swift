
import SwiftUI
import AVKit

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    
}
#endif


extension TextField {
    func extensionTextFieldView(roundedCornes: CGFloat, hexString: String, colorScheme: ColorScheme) -> some View {
        self
            .padding()
            .background(Color(UIColor(hexString: colorScheme == .dark ? "262626": "DFDFDF")))
            .cornerRadius(roundedCornes)
            .foregroundColor(colorScheme == .dark ? Color(UIColor(hexString: "DFDFDF")) : .black)
            .autocapitalization(.none) 
        
        
    }
}

extension Image {
    func icon() -> some View{
        self
            .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 70)
      //  .padding()
    }
    func defualt() -> some View{
        self
            .resizable()
        .aspectRatio(contentMode: .fit)
      //  .padding()
    }
    
    
   
}


extension Button {
    
}

struct ScrollViewWithIndicator<Content: View>: UIViewRepresentable {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true // 항상 수직 스크롤 인디케이터 표시
        scrollView.showsHorizontalScrollIndicator = true // 항상 수평 스크롤 인디케이터 표시
        scrollView.flashScrollIndicators()
        let hostingController = UIHostingController(rootView: content)
        scrollView.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            hostingController.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        // 추가적인 설정이 필요하다면 여기에 작성
    }
}


struct CustomVideoPlayer: UIViewRepresentable {
    var videoURL: URL

    func makeUIView(context: Context) -> UIView {
        let player = AVPlayer(url: videoURL)
        let playerLayer = AVPlayerLayer(player: player)
        let view = UIView()
        playerLayer.frame = view.bounds
        view.layer.addSublayer(playerLayer)
        player.play()
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // Update the view if needed
    }
}


extension View {
    func navigationBarColor(_ color: UIColor) -> some View {
        self.modifier(NavigationBarColorModifier(color: color))
    }
}

struct NavigationBarColorModifier: ViewModifier {
    var color: UIColor

    func body(content: Content) -> some View {
        content
            .onAppear {
                let coloredAppearance = UINavigationBarAppearance()
               // coloredAppearance.configureWithOpaqueBackground()
                coloredAppearance.configureWithTransparentBackground()
                coloredAppearance.titleTextAttributes = [.foregroundColor: color]
                coloredAppearance.largeTitleTextAttributes = [.foregroundColor: color]

                UINavigationBar.appearance().standardAppearance = coloredAppearance
                UINavigationBar.appearance().compactAppearance = coloredAppearance
                UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
            }
    }
}


// MARK: - 서치바
struct SearchBar: UIViewRepresentable {
    
    @Binding var text: String
    @Binding var isEnable: Bool
    @Binding var isEditing: Bool
    @Binding var isCancelButton: Bool
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        @Binding var isEnable: Bool
        @Binding var isEditing: Bool
        @Binding var isCancelButton: Bool
        init(text: Binding<String>,isEnable: Binding<Bool>, isEditing: Binding<Bool>, isCancelButton: Binding<Bool>) {
            _text = text
            _isEnable = isEnable
            _isEditing = isEditing
            _isCancelButton = isCancelButton
            
        }
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            //취소버튼 색깔
            isEditing = true
            if isCancelButton == true{
                searchBar.setShowsCancelButton(true, animated: true)
            }
          
            if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
                cancelButton.setTitleColor(UIColor.black, for: .normal)
            }
         
            
        }
        
        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            isEditing = false
            if isCancelButton == true{
                searchBar.setShowsCancelButton(false, animated: true)
               
            }

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
        return Coordinator(text: $text,isEnable: $isEnable, isEditing: $isEditing, isCancelButton: $isCancelButton)
    }
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "검색"
        if context.coordinator.isEnable == false {
            searchBar.isUserInteractionEnabled = false
        }
        if context.coordinator.isCancelButton == false {
            searchBar.showsCancelButton = false
        }
    
        //서치바 취소버튼 문구 바꾸기!!
        searchBar.setValue("취소", forKey: "cancelButtonText")
        searchBar.backgroundImage = UIImage()
        searchBar.backgroundColor = .clear
        return searchBar
    }
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
    
    
}
