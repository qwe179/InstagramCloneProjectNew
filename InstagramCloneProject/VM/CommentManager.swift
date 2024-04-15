//
//  CommentManager.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/03/26.
//

import Foundation

final class CommentManager: ObservableObject {
    static let shared = CommentManager()
    
    @Published var comments: [Comment] = []
    
    private init() {
        self.comments = [
            Comment(author: "작성자1", comment: "연소자의 근로는 특별한 보호를 받는다. 교육의 자주성·전문성·정치적 중립성 및 대학의 자율성은 법률이 정하는 바에 의하여 보장된다.", location: "서울", Date: "20240326",profile: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3qPfZgp_QU_hHIL3DWCOfQN6nHI0e0KcV8w&usqp=CAU"), isHeart: true, numberOfLike: 1),
            Comment(author: "작성자2", comment: "체포·구속·압수 또는 수색을 할 때에는 적법한 절차에 따라 검사의 신청에 의하여 법관이 발부한 영장을 제시하여야 한다. 다만, 현행범인인 경우와 장기 3년 이상의 형에 해당하는 죄를 범하고 도피 또는 증거인멸의 염려가 있을 때에는 사후에 영장을 청구할 수 있다.", location: "서울", Date: "20240326",profile: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3qPfZgp_QU_hHIL3DWCOfQN6nHI0e0KcV8w&usqp=CAU"), isHeart: true, numberOfLike: 65),
            Comment(author: "작성자3", comment: "국회의원이 회기전에 체포 또는 구금된 때에는 현행범인이 아닌 한 국회의 요구가 있으면 회기중 석방된다.", location: "서울", Date: "20240326",profile: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3qPfZgp_QU_hHIL3DWCOfQN6nHI0e0KcV8w&usqp=CAU"), isHeart: false, numberOfLike: 0),
            Comment(author: "작성자4", comment: "제1항의 지시를 받은 당해 행정기관은 이에 응하여야 한다. 국방상 또는 국민경제상 긴절한 필요로 인하여 법률이 정하는 경우를 제외하고는, 사영기업을 국유 또는 공유로 이전하거나 그 경영을 통제 또는 관리할 수 없다.", location: "서울", Date: "20240326",profile: nil, isHeart: true, numberOfLike: 100)
        ]
    }
    
    
}
