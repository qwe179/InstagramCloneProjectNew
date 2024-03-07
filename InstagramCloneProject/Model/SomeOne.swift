//
//  Someone.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/02/29.
//

import Foundation
import SwiftUI
struct SomeOne: Equatable {
    var name: String
    var contents: String
    var imageURLs: [URL?]
    var location: String
    var numberOfLike: Int
    var profilePhoto: URL
    
    static func == (lhs: SomeOne, rhs: SomeOne) -> Bool {
        return lhs.name == rhs.name
    }
    
}
