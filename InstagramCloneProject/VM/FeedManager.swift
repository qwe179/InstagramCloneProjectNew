//
//  FeedManager.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/03/04.
//

import Foundation
import Combine
final class FeedManager: ObservableObject {
    static let shared = FeedManager()

    @Published var feed: [SomeOne] = []
    @Published var feedCounts: Int = 0
    private init(){
        self.setFeedSomeOne(name: "jiwoo", urls: [ "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4em6wQUFde53F-EMT90jOTwTYIqsX3JaxQ1Fd5OROtw&s", "https://mblogthumb-phinf.pstatic.net/MjAxOTA1MDdfMjc1/MDAxNTU3MjE5MTgzMjY5.DQwQpQFlVNGMsF0xgb8CnD0ZxU6eUcXt7gfBPqinEkMg.NoSOhwRQP5FlCP3UIjaGonLyXc-gphDAsaZvdK0au1sg.PNG.cine_play/%ED%94%BC%EC%B9%B4%EC%B8%842.png?type=w800","https://mblogthumb-phinf.pstatic.net/MjAxNzAzMzFfNjEg/MDAxNDkwOTM2NjE4MDQy.eIMvlKaVriccpz8TPo-Wyagr3J6oEz_pRe3S32gADVIg.jQUkh4ws9TiGn6y2h2iu3z5xmyKvxrRMgS0rjJVTRPQg.PNG.jkirby/%EC%9E%A0%EB%A7%8C%EB%B3%B4.png?type=w800"], location: "japan", numberOfLike: 1000,profile: "https://i.namu.wiki/i/t7FadQzp0lWI8Uv53dQuqqWhmaYzLLTB5E_nP7di50tYMyVC8kqppQ7LEWlVX54CUfFl3ydqQjFccV4U5NVfzg.webp", contents: "피카")
        self.setFeedSomeOne(name: "임영웅", urls: [ "https://yt3.googleusercontent.com/XYOs6XHWO7DycO6XPPvIbomEjljA3lssqXOFDppTqb2CVv4zLhs7gXAyl2Ke7jtghbMCdN7XMVE=s900-c-k-c0x00ffffff-no-rj", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4Y_ut2EtFRiipAdUHWVLHcHd0EMG29DRBIoXrdIZerugVzbGekMYV2cdOZRsDc-JQmoY&usqp=CAU"], location: "korea", numberOfLike: 50000,profile:"https://flexible.img.hani.co.kr/flexible/normal/611/508/imgdb/original/2023/1019/20231019501258.jpg", contents: "안녕하세요 임영웅입니다")
        self.setFeedSomeOne(name: "Lisa", urls: [ "https://thumb.mtstarnews.com/06/2022/12/2022120721524745008_1.jpg/dims/optimize", "https://mblogthumb-phinf.pstatic.net/MjAyMDEwMjhfMjE3/MDAxNjAzODY5NDE2MDU1.ZJ4TqSDVeYW35chb-X2FzKm6bGh0nWBquLyu-L3ZiRog.jNkj-9PiPoU-54ahFp7wy4zyNPdLri-4uEf1T02yXxEg.JPEG.jaejinruby/lalalalisa_m_56679691_698144220623474_9073266633277741309_n.jpg?type=w800","https://ilyo.co.kr/contents/article/images/2022/0316/1647400582997111.jpg","https://images.khan.co.kr/article/2023/10/04/news-p.v1.20231004.0a7e851e86064553bdb937f6fa78ad41_P1.jpg"], location: "korea", numberOfLike: 70000,profile:"https://img5.yna.co.kr/photo/cms/2022/06/24/88/PCM20220624000588505_P2.jpg", contents: "내 예쁜 얼굴")
        self.setFeedSomeOne(name: "손흥민", urls: [ "https://cdn.mhnse.com/news/photo/202301/164911_160972_037.jpg", "https://assets.goal.com/v3/assets/bltcc7a7ffd2fbf71f5/bltaf10a2ea551a3e54/6360dc8f67675010b765f257/GettyImages-1432946487.jpg?auto=webp&format=pjpg&width=3840&quality=60","https://img.khan.co.kr/news/2022/12/22/l_2022122301001060400086601.jpg","https://img.khan.co.kr/news/2022/11/10/l_2022111101000537100046401.jpg"], location: "korea", numberOfLike: 50000000,profile:"https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Team_Korea_Russia_WorldCup_02_%28cropped%29.png/200px-Team_Korea_Russia_WorldCup_02_%28cropped%29.png", contents: "내 세레머니 모음ㅋ")
        self.setFeedSomeOne(name: "등산가", urls: [ "https://images.unsplash.com/photo-1503614472-8c93d56e92ce?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8fA%3D%3D","https://images.unsplash.com/photo-1461301214746-1e109215d6d3?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8NXx8fGVufDB8fHx8fA%3D%3D", "https://images.unsplash.com/photo-1549558549-415fe4c37b60?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8M3x8fGVufDB8fHx8fA%3D%3D","https://img.khan.co.kr/news/2022/12/22/l_2022122301001060400086601.jpg","https://img.khan.co.kr/news/2022/11/10/l_2022111101000537100046401.jpg"], location: "America", numberOfLike: 3,profile:"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkppAh1hOqgsxqdRQ63h8_DId8cLsMEWpgeA&usqp=CAU", contents: "내가 등산한 산들 ㅎㅎ")
        
        self.feedCounts = self.feed.count
    }
    private func getFeedCount() -> Int {
        return self.feedCounts
    }
    
    private func setFeedSomeOne(name: String, urls: [String], location: String?, numberOfLike: Int, profile: String,contents: String?) {
        guard let profileUrl = URL(string: profile) else {return}
        let one = SomeOne(name: name, contents: contents ?? "내용 없음", imageURLs: urls.map { URL(string: $0) }, location: location ?? "서울", numberOfLike: numberOfLike, profilePhoto: profileUrl)
        addOneToFeed(one)
    }
    
    private func addOneToFeed(_ someOne: SomeOne) {
        feed.append(someOne)
    }
    private func removeOneFromFeed(_ someOne: SomeOne) {
        if let firstIndex = feed.firstIndex(of: someOne) {
            feed.remove(at: firstIndex)
        }
    }
    
    private func getFeed() -> [SomeOne] {
        return self.feed
    }
    
    private func clearSomeOne() {
        self.feed = []
    }
}
