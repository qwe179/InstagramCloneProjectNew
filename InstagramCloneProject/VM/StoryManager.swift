//
//  StoryManager.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/03/05.
//


import Foundation
import Combine
final class StoryManager: ObservableObject {
    static let shared = StoryManager()

    @Published var stories: [Story] = []
    @Published var storyCount: Int = 0
    
    
    private var publishers = Set<AnyCancellable>()
    
    private init(){
        self.stories = [
            Story(name: "test3", profilePhoto:        URL(string:"https://png.pngtree.com/thumb_back/fh260/background/20210903/pngtree-sunflower-summer-flower-park-flower-viewing-photograph-with-picture-image_800938.jpg")!, time: "1시간"),
            Story(name: "test4", profilePhoto: URL(string:"https://i.pinimg.com/736x/2c/2c/60/2c2c60b20cb817a80afd381ae23dab05.jpg")!, time: "1시간"),
            Story(name: "test3", profilePhoto: URL(string:"https://gongu.copyright.or.kr/gongu/wrt/cmmn/wrtFileImageView.do?wrtSn=11288734&filePath=L2Rpc2sxL25ld2RhdGEvMjAxNS8wMi9DTFM2OS9OVVJJXzAwMV8wMjIwX251cmltZWRpYV8yMDE1MTIwMw==&thumbAt=Y&thumbSe=b_tbumb&wrtTy=10006")!, time: "1시간"),
            Story(name: "test3", profilePhoto: URL(string:"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjbF0EG5rquOTaEGzIM6IgTny7QaouoRvRxw&usqp=CAU")!, time: "1시간"),
            Story(name: "test3", profilePhoto: URL(string:"https://lh3.googleusercontent.com/proxy/i-tTD4ybtIgTMR2vFBv3ozV8p31Tx1SareEIM78euvzqlyHXhG-GsBR_Hb1xWx9jywI18mRvm7kNFzxkkuEXpAjjPkfSurOWwBhsvgmrqnq9O7Pp6Liftlbo51Jcnk4")!, time: "1시간"),
            Story(name: "test3", profilePhoto: URL(string:"https://png.pngtree.com/thumb_back/fh260/background/20230609/pngtree-three-puppies-with-their-mouths-open-are-posing-for-a-photo-image_2902292.jpg")!, time: "1시간")
        ]
        storyCount = self.stories.count
        // MARK: - 데이터 새로 가져오는 새로고침 이벤트 구독
        NotificationCenter.default.publisher(for: .customEvent)
            .sink { [weak self] _ in
                self?.fetchData()
            }
            .store(in: &publishers)
    }
    deinit {
        publishers.forEach { $0.cancel() }
     }
    
    func fetchData() {
        self.stories.removeAll()
        // 여기에서 데이터를 가져오는 비동기 동작 수행
        // 가져온 데이터는 @Published로 선언한 프로퍼티에 할당되어 UI에 업데이트될 것
        self.stories = [
            Story(name: "test5", profilePhoto:        URL(string:"https://images.pexels.com/photos/2859616/pexels-photo-2859616.jpeg?cs=srgb&dl=pexels-barcelosfotos-2859616.jpg&fm=jpg")!, time: "4시간"),
            Story(name: "test6", profilePhoto: URL(string:"https://img.allurekorea.com/allure/2023/08/style_64e9455e27b2a-560x700.jpeg")!, time: "5시간"),
            Story(name: "test7", profilePhoto: URL(string:"https://img.kbs.co.kr/kbs/620/news.kbs.co.kr/data/fckeditor/new/image/2021/01/25/323431611532663178.jpg")!, time: "6시간")
        ]
        self.storyCount = self.stories.count
        
    }
    
    private func getStoryCount() -> Int {
        return self.storyCount
    }
    
    private func addOneToFeed(_ story: Story) {
        stories.append(story)
    }
}
