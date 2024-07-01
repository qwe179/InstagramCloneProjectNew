//
//  Comment.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/03/04.
//

import Foundation
struct Comment: Equatable {
    var author: String
    var comment: String
    var location: String?
    var Date: String
    var profile: URL?
    var isHeart: Bool
    var numberOfLike: Int
}
