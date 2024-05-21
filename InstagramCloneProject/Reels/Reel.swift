//
//  Reel.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/05/21.
//

import Foundation
import AVKit

struct Reel: Identifiable {
    var id = UUID().uuidString
    var player: AVPlayer?
    var mediaURL: MediaFile
    var title = ""
    var user: ReelsUser
}

struct ReelsUser {
    var userId = UUID().uuidString
    var userProfile: String 
    var userName: String 
    var heartNum: Int
    var commentNum: Int
}

struct MediaFile: Identifiable {
    var id = UUID().uuidString
    var url: String
    var isExpanded: Bool = false
}
//
//var MediaFileJSON = [
//    MediaFile(url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4"),
//    MediaFile(url: "https://cdn.pixabay.com/video/2023/08/20/176963-856267342_large.mp4"),
//    MediaFile(url: "https://cdn.pixabay.com/video/2024/02/27/202179-917223905_large.mp4")
//]
