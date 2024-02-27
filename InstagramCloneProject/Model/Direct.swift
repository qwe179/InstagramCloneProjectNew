//
//  Direct.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/03/03.
//

import Foundation

enum Direct {
    case none
    case up
    case down
    
    var title: String {
        switch self {
            case .none: return "ㅇㅇ"
            case .up: return "위"
            case .down: return "아래"
        }
    }
}
