//
//  Navigation_Extensions.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/03/07.
//

import SwiftUI
extension View {
    @ViewBuilder
    func hideNavBarOnSwipe(_ isHidden: Bool) -> some View {
        self
            .modifier(NavBarModifier(isHidden: isHidden))
    }
}

private struct NavBarModifier: ViewModifier {
    var isHidden: Bool
  //  @State private var isNavBarHidden: Bool?
    func body(content: Content) -> some View {
//        if #available(iOS 17.0, *)  {
//            content
//                .onChange(of: isHidden, initial: true, {
//                    oldValue, newValue in
//                    isNavBarHidden = newValue
//                })
//                .onDisappear(perform: {
//                    isNavBarHidden = nil
//                })
//                //
//                .background(NavigationControllerExtractor(isHidden: isHidden))
        content
            .background(NavigationControllerExtractor(isHidden: isHidden))
        //}

    }
}
// MARK: - UIView 를 SwiftUI 에서 사용할수 있게 해주는 프로토콜(UIViewRepresentable)

private struct NavigationControllerExtractor: UIViewRepresentable {
    var isHidden: Bool?
    // MARK: - 빈 UIView 생성하는 메서드
    func makeUIView(context: Context) -> UIView {
     let a = UIView()
            a.backgroundColor = .white
        return a
    }
    
    // MARK: - 뷰가 업데이트될 때 호출된다
    func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01){
            // MARK: - 부모의 부모 찾아서 네비게이션컨트롤러 숨었는지 확인
            if let hostView = uiView.superview?.superview, let parentController = hostView.parentController {
                if let isHidden {
                    // MARK: - 네비게이션컨트롤러의 하이드바온스와이프 속성 사용
                    parentController.navigationController?.hidesBarsOnSwipe = isHidden
                    parentController.navigationController?.navigationBar.barTintColor = UIColor.white
                 //   parentController.navigationController?.navigationBar.barTintColor = UIColor.black
                  
       
                //    parentController.navigationController?.tabBarController?.tabBar.backgroundColor = .black
                    parentController.tabBarController?.tabBar.backgroundColor = .white
                }
                //print("isHidden::",isHidden)
            }
 
        }
    }
}

// MARK: - 가장가까운 상위 부모뷰 찾는 코드

private extension UIView {
    var parentController: UIViewController? {
        sequence(first: self){
            view in view.next
        }
        .first { responder in
            return responder is UIViewController
        } as? UIViewController
    }
}
