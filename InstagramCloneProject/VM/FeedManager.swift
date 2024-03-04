//
//  FeedManager.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/03/04.
//

import Foundation
import Combine
class FeedManager: ObservableObject {
    var someOne: Someone?
    
    
    func setFeedSomeone(name: String, urls: [String], location: String?, numberOfLike: Int) {
        self.someOne = Someone(name: name, contents: "첫 게시물입니다 ㅎㅎ", imageURLs: urls.map { URL(string: $0) }, location: location, numberOfLike: numberOfLike)
    }
    
}
