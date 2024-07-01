//
//  MyViewDataManager.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/04/22.
//

import Foundation
import Combine

class ExploreViewDataManager: ObservableObject {
    @Published var users: [ExploreViewUser] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchUserData()
    }
    
    func fetchUserData() {
        let users = [
                    ExploreViewUser(id: 0, name: "Comong", imageInfo: [.adv(video: false, url: "https://media.istockphoto.com/id/1417064745/ko/%EC%82%AC%EC%A7%84/%EB%B0%94%EB%8B%A4-%EA%B7%BC%EC%B2%98%EC%97%90%EC%84%9C-%EC%85%80%EC%B9%B4%EB%A5%BC%ED%95%98%EB%8A%94-%EC%BB%A4%ED%94%8C%EC%9D%98-%ED%81%B0-%EC%B4%AC%EC%98%81.jpg?s=2048x2048&w=is&k=20&c=OGWhjoICaCvzLBKqKbW6Pf5BJAnxYb2DhnYEOw4-H18=")]),
                     ExploreViewUser(id: 1, name: "Comong", imageInfo: [.feed(video: false, url: "https://images.unsplash.com/photo-1713453321322-28ef26986cc0?q=80&w=2071&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")]),
                    ExploreViewUser(id: 2, name: "Comong", imageInfo: [.feed(video: false, url: "https://plus.unsplash.com/premium_photo-1673152979577-64b00806a6d1?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")]),
                    ExploreViewUser(id: 3, name: "Comong", imageInfo: [.feed(video: false, url: "https://images.unsplash.com/photo-1712149851157-06131345e410?q=80&w=1976&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")]),
                    ExploreViewUser(id: 4, name: "Comong", imageInfo: [.feed(video: false, url: "https://designbase.co.kr/wp-content/uploads/2022/03/illustrator-advanced-15-overview.jpg")]),
                    ExploreViewUser(id: 5, name: "Comong", imageInfo: [.feed(video: false, url: "https://images.unsplash.com/photo-1712313197947-404fa28723cf?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")]),
                    ExploreViewUser(id: 7, name: "Comong", imageInfo: [.feed(video: false, url: "https://images.unsplash.com/photo-1613390074134-51e38e67e1ec?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")]),
                    ExploreViewUser(id: 8, name: "Comong", imageInfo: [.reels(video: true, url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4")]),
                    ExploreViewUser(id: 9, name: "Comong", imageInfo: [.feed(video: false, url: "https://images.unsplash.com/photo-1464802686167-b939a6910659?q=80&w=2050&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),.feed(video: false, url: "https://images.unsplash.com/photo-1713204641929-690f1c083dd9?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")]),
                    ExploreViewUser(id: 10, name: "Comong", imageInfo: [.feed(video: false, url: "https://plus.unsplash.com/premium_photo-1713009135066-f373c1d30fb6?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")]),
                    ExploreViewUser(id: 11, name: "Comong", imageInfo: [.feed(video: false, url: "https://images.unsplash.com/photo-1610296669228-602fa827fc1f?q=80&w=1975&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")]),
                    ExploreViewUser(id: 11, name: "Comong", imageInfo: [.feed(video: false, url: "https://plus.unsplash.com/premium_photo-1677511580659-f5fa0675a547?q=80&w=1932&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")]),
                    ExploreViewUser(id: 0, name: "Comong", imageInfo: [.feed(video: false, url: "https://images.unsplash.com/photo-1528722828814-77b9b83aafb2?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")]),
                     ExploreViewUser(id: 1, name: "Comong", imageInfo: [.feed(video: false, url: "https://images.unsplash.com/photo-1446776811953-b23d57bd21aa?q=80&w=2072&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")]),
                    ExploreViewUser(id: 2, name: "Comong", imageInfo: [.feed(video: false, url: "https://images.unsplash.com/photo-1516339901601-2e1b62dc0c45?q=80&w=1942&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")]),
                    ExploreViewUser(id: 3, name: "Comong", imageInfo: [.feed(video: false, url: "https://images.unsplash.com/photo-1711116180104-b737dccc850b?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")]),
                    ExploreViewUser(id: 4, name: "Comong", imageInfo: [.feed(video: false, url: "https://plus.unsplash.com/premium_photo-1675978139591-0d7962580002?q=80&w=1957&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")]),
                    ExploreViewUser(id: 5, name: "Comong", imageInfo: [.feed(video: false, url: "https://plus.unsplash.com/premium_photo-1711132342298-8afe852bd3f3?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")]),
                    ExploreViewUser(id: 7, name: "Comong", imageInfo: [.feed(video: false, url: "https://images.unsplash.com/photo-1543722530-d2c3201371e7?q=80&w=2074&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")]),
                    ExploreViewUser(id: 8, name: "Comong", imageInfo: [.reels(video: true, url: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4")]),
                    ExploreViewUser(id: 9, name: "Comong", imageInfo: [.feed(video: false, url: "https://images.unsplash.com/photo-1713422107968-80a9bdcac8e6?q=80&w=2053&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),.feed(video: false, url: "https://images.unsplash.com/photo-1484589065579-248aad0d8b13?q=80&w=1959&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")]),
                    ExploreViewUser(id: 10, name: "Comong", imageInfo: [.feed(video: false, url: "https://images.unsplash.com/photo-1501862700950-18382cd41497?q=80&w=2019&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")]),
                    ExploreViewUser(id: 11, name: "Comong", imageInfo: [.feed(video: false, url: "https://images.unsplash.com/photo-1474511320723-9a56873867b5?q=80&w=2072&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")]),
                    ExploreViewUser(id: 12, name: "Comong", imageInfo: [.feed(video: false, url: "https://media.istockphoto.com/id/1512660779/ko/%EC%82%AC%EC%A7%84/%ED%95%9C%EA%B5%AD%EC%9D%98-%EC%9E%90%EC%9D%B4%EC%96%B8%ED%8A%B8-%ED%8C%90%EB%8B%A4%EB%A5%BC-%ED%81%B4%EB%A1%9C%EC%A6%88%EC%97%85%ED%95%98%EC%84%B8%EC%9A%94.jpg?s=2048x2048&w=is&k=20&c=Es8V_KD0OEVNNTEUAFQ5GA0HXsp5lrJpHgqgFTP2j94=")])
        ]
        
        Just(users)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] users in //users에 대한 처리
                self?.users = users
            })
            .store(in: &cancellables)
    }
}
