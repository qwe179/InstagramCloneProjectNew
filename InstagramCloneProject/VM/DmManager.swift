//
//  DmManager.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/03/25.
//

import Foundation

final class DmManager: ObservableObject {
    static let shared = DmManager()
    var followers: [Follower]
    var receiverCnt: Int = 0
    @Published var receivers: [Follower] = []
    private init(){
        followers = [
            Follower(name: "친구1", profile: URL(string: "https://isplus.com/data/isp/image/2023/12/15/isp20231215000138.800x.8.jpg"), id: "1"),
            Follower(name: "친구2", profile: URL(string: "https://img.hankyung.com/photo/201811/01.18271154.1.jpg"), id: "2"),
            Follower(name: "친구3", profile: URL(string: "https://cdn.bokjitimes.com/news/photo/202002/22767_15736_3416.jpg"), id: "3"),
            Follower(name: "친구4", profile: URL(string: "https://img.sbs.co.kr/newsnet/etv/upload/2023/01/26/30000820991_500.jpg"), id: "4"),
            Follower(name: "친구5", profile: URL(string: "https://image.xportsnews.com/contents/images/upload/article/2023/0814/mb_1691991078592203.jpg"), id: "5"),
            Follower(name: "친구6", profile: URL(string: "https://www.viva100.com/mnt/images/file/2023y/08m/30d/20230830010008822_1.jpg"), id: "6"),
            Follower(name: "친구7", profile: URL(string: "https://pds.joongang.co.kr/news/component/htmlphoto_mmdata/202109/09/0bc53de8-68db-487e-816b-1d26d40cf8de.jpg"), id: "7"),
            Follower(name: "친구8", profile: URL(string: "https://img1.daumcdn.net/thumb/R658x0.q70/?fname=https://t1.daumcdn.net/news/202303/13/sbsnoriter/20230313145738118regu.jpg"), id: "8"),
            Follower(name: "친구9", profile: URL(string: "https://res.heraldm.com/content/image/2022/07/07/20220707000159_0.jpg"), id: "9"),
            Follower(name: "친구10", profile: URL(string: "https://img.allurekorea.com/allure/2023/10/style_65389c877d8df-1200x678.png"), id: "10"),
        ]
    }
    
    func getFollowers() -> [Follower] {
        return self.followers
    }
    
    func addReciever(_ follower: Follower) {
        self.receivers.append(follower)
    }
    
    func removeReciever(_ follower: Follower) {
        if let index = self.receivers.firstIndex(where: { $0 == follower }) {
            receivers.remove(at: index)
        }
    }
    
    func getRecievers() -> [Follower] {
        return self.receivers
    }
    
}
