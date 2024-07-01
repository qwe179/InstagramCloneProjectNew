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
            Story(name: "josias", profilePhoto:        URL(string:"https://png.pngtree.com/thumb_back/fh260/background/20210903/pngtree-sunflower-summer-flower-park-flower-viewing-photograph-with-picture-image_800938.jpg")!, time: "1시간"),
            Story(name: "dorotty", profilePhoto: URL(string:"https://i.pinimg.com/736x/2c/2c/60/2c2c60b20cb817a80afd381ae23dab05.jpg")!, time: "1시간"),
            Story(name: "damjan", profilePhoto: URL(string:"https://gongu.copyright.or.kr/gongu/wrt/cmmn/wrtFileImageView.do?wrtSn=11288734&filePath=L2Rpc2sxL25ld2RhdGEvMjAxNS8wMi9DTFM2OS9OVVJJXzAwMV8wMjIwX251cmltZWRpYV8yMDE1MTIwMw==&thumbAt=Y&thumbSe=b_tbumb&wrtTy=10006")!, time: "1시간"),
            Story(name: "deiphous", profilePhoto: URL(string:"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjbF0EG5rquOTaEGzIM6IgTny7QaouoRvRxw&usqp=CAU")!, time: "1시간"),
            Story(name: "xuthus", profilePhoto: URL(string:"https://images.unsplash.com/photo-1566572176693-74c6688e0141?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDh8dG93SlpGc2twR2d8fGVufDB8fHx8fA%3D%3D")!, time: "1시간"),
            Story(name: "magnus", profilePhoto: URL(string:"https://png.pngtree.com/thumb_back/fh260/background/20230609/pngtree-three-puppies-with-their-mouths-open-are-posing-for-a-photo-image_2902292.jpg")!, time: "1시간")
        ]
        storyCount = self.stories.count
        // MARK: - 데이터 새로 가져오는 새로고침 이벤트 구독
//        NotificationCenter.default.publisher(for: .customEvent)
//            .sink { [weak self] _ in
//                self?.fetchData()
//            }
//            .store(in: &publishers)
    }
    deinit {
        publishers.forEach { $0.cancel() }
     }
    
    func fetchData()  {
     //   DispatchQueue.main.async {
            
            self.stories.removeAll()
            // 여기에서 데이터를 가져오는 비동기 동작 수행
            // 가져온 데이터는 @Published로 선언한 프로퍼티에 할당되어 UI에 업데이트될 것
            self.stories = [
                Story(name: "MAITLAND", profilePhoto:        URL(string:"https://images.pexels.com/photos/2859616/pexels-photo-2859616.jpeg?cs=srgb&dl=pexels-barcelosfotos-2859616.jpg&fm=jpg")!, time: "4시간"),
                Story(name: "FORSTER", profilePhoto: URL(string:"https://images.unsplash.com/photo-1651602701319-491d146f2c9f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDQxfHRvd0paRnNrcEdnfHxlbnwwfHx8fHw%3D")!, time: "5시간"),
                Story(name: "TASSO", profilePhoto: URL(string:"https://img.kbs.co.kr/kbs/620/news.kbs.co.kr/data/fckeditor/new/image/2021/01/25/323431611532663178.jpg")!, time: "1시간"),
                Story(name: "AGLAIA", profilePhoto: URL(string:"https://plus.unsplash.com/premium_photo-1681484125475-7c5d3fe342f6?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDI3fHRvd0paRnNrcEdnfHxlbnwwfHx8fHw%3D")!, time: "2시간"),
                Story(name: "GIEFFROY", profilePhoto: URL(string:"https://images.unsplash.com/flagged/photo-1572262107174-2c8052b632ab?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDI5fHRvd0paRnNrcEdnfHxlbnwwfHx8fHw%3D")!, time: "20분"),
                Story(name: "ACHICAUHTLI", profilePhoto: URL(string:"https://images.unsplash.com/photo-1645093861533-7730c865817f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDM1fHRvd0paRnNrcEdnfHxlbnwwfHx8fHw%3D")!, time: "7시간"),
                Story(name: "LEON", profilePhoto: URL(string:"https://images.unsplash.com/photo-1631678155206-62db035bba14?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDM4fHRvd0paRnNrcEdnfHxlbnwwfHx8fHw%3D")!, time: "9시간")
            ]
            self.storyCount = self.stories.count
     //   }
 
        
    }
    
    private func getStoryCount() -> Int {
        return self.storyCount
    }
    
    private func addOneToFeed(_ story: Story) {
        stories.append(story)
    }
}
