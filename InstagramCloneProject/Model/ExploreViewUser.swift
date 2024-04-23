//
//  ExploreViewUser.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/04/22.
//

import Foundation

struct ExploreViewUser: Identifiable, Equatable, Hashable {
    static func == (lhs: ExploreViewUser, rhs: ExploreViewUser) -> Bool {
        return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    let id: Int
    let name: String
    let imageInfo: [ImageInfo]
}

//struct ImageInfo {
//    var urls: [URL]
//    var isReels: Bool
//    var isAdvs: Bool
//    var isVideo: Bool
//    
//    init(urls: [String], isReels: Bool, isAdvs: Bool, isVideo: Bool) {
//        var tmp: [URL] = []
//        for urlString in urls {
//            if let url = URL(string: urlString) {
//                tmp.append(url)
//            }
//        }
//        self.urls = tmp
//        self.isReels = isReels
//        self.isAdvs = isAdvs
//        self.isVideo = isVideo
//    }
//}

enum ImageInfo {
    case reels(video: Bool, url: String)
    case adv(video: Bool, url: String)
    case feed(video: Bool, url: String)
}
