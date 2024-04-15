
import SwiftUI

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


