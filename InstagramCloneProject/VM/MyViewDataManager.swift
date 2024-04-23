//
//  MyViewDataManager.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/04/15.
//

import Foundation
import Combine

class MyViewManager: ObservableObject {
    @Published var user: User?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // 실제로는 네트워크 요청을 보내서 유저 정보를 가져와야 합니다.
        // 여기서는 임의의 데이터를 사용합니다.
        fetchUserData()
    }
    
    func fetchUserData() {
        // 실제로는 네트워크 요청을 보내서 유저 정보를 가져오는 로직이 들어갑니다.
        // 여기서는 임의의 데이터를 생성하여 사용합니다.
        let user = User(id: 0 ,name: "Comong", imageURL: [URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRKl1B5A3Xg4g9HPZBr1EPI-VaX_-f9ZGBx0scaDPL_nA&s")!,
                                                            URL(string: "https://ojsfile.ohmynews.com/STD_IMG_FILE/2022/0111/IE002923737_STD.jpg")!,
                                                            URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtjs8w1pepAW689-pDDXf3sogz5clgHq-qc878CB8exg&s")!,
                                                            URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSVA0y7IqjMnAIZFtV5L8TbF54EjhsANHIRmv3vNlNvwQ&s")!,
                                                            URL(string: "https://kukka-2-media-123.s3.amazonaws.com/media/contents/main_item/web/7b06f20c-4705-43a6-9f0d-49ecf0d72e3c.jpg")!], videos: [
            URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4")!,
            URL(string: "https://video.twimg.com/amplify_video/1760315643142750208/vid/avc1/640x360/-1etorSK7w2g9Nlc.mp4?tag=16")!,
            URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4")!
        ])
        
        Just(user)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] user in //user에 대한 처리
                self?.user = user
            })
            .store(in: &cancellables)
    }
}
