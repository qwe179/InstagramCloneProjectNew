//
//  ReelsViewModel.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/05/21.
//

import Foundation
import AVKit

class ReelsViewModel: ObservableObject {
    @Published var reels: [Reel] = []
    
    init() {
        reels.append(Reel(player: AVPlayer(url: URL(string:"https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4")!), mediaURL: MediaFile(url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4"), user: ReelsUser(userProfile: "test", userName: "comong", heartNum: 1000, commentNum: 14) ))
        reels.append(Reel(player: AVPlayer(url: URL(string:"https://cdn.pixabay.com/video/2024/02/27/202179-917223905_large.mp4")!), mediaURL: MediaFile(url: "https://cdn.pixabay.com/video/2024/02/27/202179-917223905_large.mp4"), user: ReelsUser(userProfile: "test2", userName: "hoho", heartNum: 700, commentNum: 100) ))
        reels.append(Reel(player: AVPlayer(url: URL(string:"https://cdn.pixabay.com/video/2023/08/20/176963-856267342_large.mp4")!), mediaURL: MediaFile(url: "https://cdn.pixabay.com/video/2023/08/20/176963-856267342_large.mp4"), user: ReelsUser(userProfile: "test3", userName: "some", heartNum: 50, commentNum: 400) ))
    }
}
