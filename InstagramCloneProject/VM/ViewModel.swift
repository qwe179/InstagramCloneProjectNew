//
//  ViewModel.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/03/03.
//

import SwiftUI



final class ViewModel: ObservableObject {
    @Published var offset: CGFloat = 0
    @Published var direct: Direct = .none
    @Published  var originOffset: CGFloat = 0
     var isCheckedOriginOffset: Bool = false
    
    func setOriginOffset(_ offset: CGFloat) {
        guard !isCheckedOriginOffset else { return }
        self.originOffset = offset
        self.offset = offset
        isCheckedOriginOffset = true
    }
    
    func setOffset(_ offset: CGFloat) {
        guard isCheckedOriginOffset else { return }
        if self.offset < offset {
            direct = .down
        } else if self.offset > offset {
            direct = .up
        } else {
            direct = .none
        }
        self.offset = offset
       
    }
}
