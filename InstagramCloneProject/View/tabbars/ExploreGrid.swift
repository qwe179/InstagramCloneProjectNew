//
//  ExploreGrid.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/04/20.
//

import SwiftUI
import Kingfisher
import AVKit

struct ExploreGrid: View {

    var vm: ExploreViewDataManager
    let layoutImgStrings: [[ExploreViewUser]]
    var spacing: CGFloat = 2
    var reader: GeometryProxy
    var isReelsFlag: Bool = false
    var isAdv: Bool = false
    var reelsIndex: Int = 0
    
    init(vm: ExploreViewDataManager, spacing: CGFloat = 2, reader: GeometryProxy) {
        self.vm = vm
        var tmp: [ExploreViewUser] = []
        var layoutImgStrings: [[ExploreViewUser]] = []
        //로우당 유저 최대갯수
        var imageCount: Int = 3
        for user in vm.users {
            tmp.append(user)
            
            switch user.imageInfo[0] {
            case .reels(let video, let url):
                imageCount = 5
            case .adv(let video, let url):
                imageCount = 3
            case .feed(let video, let url): 
                break
            }
           // imageCount = 3
            if tmp.count >= imageCount {
                layoutImgStrings.append(tmp)
                tmp.removeAll()
                //로우당 이미지 최대갯수 초기화
                imageCount = 3
            }
        }
     
//            if user.imageInfo.isReels == true {
//                print("user.imageInfo.isReels:",user.imageInfo.isReels)
//                imageCount = 5
//            }
//            
//            //광고가있으면 무조건 3개
//            if user.imageInfo.isAdvs == true {
//                imageCount = 3
//            }

        if !tmp.isEmpty {
            layoutImgStrings.append(tmp)
        }
        //변수, 상수에 저장
        self.layoutImgStrings = layoutImgStrings
        self.spacing = spacing
        self.reader = reader
        
    }
//
//        var layoutImgStrings = [[String]]()
//        var tmp = [String]()
//  
//        //로우당 이미지 최대갯수
//        var imageCount: Int = 3
//        for img in imgStrings {
//            //이미지 이름 string 을 임시 String배열(tmp)에 넣는다.
//            tmp.append(img)
//            //tmp배열의 이미지갯수가 3개가 되면,
//            //layoutImgStrings String배열 배열에 넣고, tmp배열은 초기화한다.
//            //릴스가 하나라도 있으면 로우당 이미지 최대갯수를 5개로 올린다.
//            if isReels == true {
//                imageCount = 5
//            }
//            //광고가있으면 무조건 3개
//            if isAdv == true {
//                imageCount = 3
//            }
//            if tmp.count >= imageCount {
//                layoutImgStrings.append(tmp)
//                tmp.removeAll()
//                //로우당 이미지 최대갯수 초기화
//                imageCount = 3
//            }
//        }//만약에 이미지 갯수가 3의배수로 떨어지지 않으면 layoutImgStrings 에 안들어갔을것이므로 넣어준다.

    var body: some View {
        VStack(spacing: spacing) {
            let viewWidth: CGFloat = reader.size.width
            ForEach(Array(layoutImgStrings.enumerated()), id: \.offset) { i, _ in
                let imgStrings = layoutImgStrings[i]
                
                // imageInfo 배열에 isAdvs를 포함하는지 확인
                let containsAdvs = imgStrings.contains { user in
                    if case .adv(_, _) = user.imageInfo[0] {
                        return true
                    } else {
                        return false
                    }
                }
                
                //짝수번째 줄 첫번째 레이아웃
                if i % 2 == 1, imgStrings.count == 5 {
                    Layout4(imgStrings: imgStrings, viewWidth: viewWidth, spacing: spacing )
                    
                } 
                //홀수번째 줄 두번째 레이아웃
                else if i % 2 == 0 , imgStrings.count == 5 {
                    Layout5(imgStrings: imgStrings, viewWidth: viewWidth, spacing: spacing )
                } 
                else if imgStrings.count < 4, containsAdvs == false {
                    Layout1(imgStrings: imgStrings, viewWidth: viewWidth, spacing: spacing )
                }
                else {
                    //2,5,8,11,14,17,20
                    //2번째,8번째,14번째,20번째 ... 순으로 두번째 레이아웃
                    if i % 2 == 0 {
                        Layout2(imgStrings: imgStrings, viewWidth: viewWidth, spacing: spacing )
                    }//5번째,11번째,17번째 ... 순으로 두번째 레이아웃
                    else {
                        Layout3(imgStrings: imgStrings, viewWidth: viewWidth, spacing: spacing )
                    }
                }
            }
            
        }
    }
    
    
}


struct Layout1: View {
    var imgStrings: [ExploreViewUser]
    let viewWidth: CGFloat
    let spacing: CGFloat
    
    var body: some View {
        //spacing 고려해서 가로세로 높이를 잡아준닷
        //viewWidth 는 뷰전체의 가로 길이
        let height: CGFloat = (viewWidth - (2 * spacing)) / 3
        return HStack(spacing: spacing) {
            ForEach(imgStrings, id: \.self) { imgString in
                if case let .feed(video, url) = imgString.imageInfo[0]  {
                    if video == true {
                        
                    } else {
                        
                        KFImage(URL(string: url)!)
                            .resizable()
                            .frame(width: height, height: height)
                            .scaledToFill()
                            .onAppear {
                                print("내부 이미지url : ",url)
                            }
                        
                    }
                }
         
                
            }
        }
        .frame(width: viewWidth, height: height, alignment: .leading)
        .onAppear {
            if imgStrings.count == 2 {
                print("imgStrings[0]:",imgStrings[0])
                print("imgStrings[1]:",imgStrings[1])
            }
  
        }
    }
}

struct Layout2: View {
    var imgStrings: [ExploreViewUser]
    let viewWidth: CGFloat
    let spacing: CGFloat
    
    init(imgStrings: [ExploreViewUser], viewWidth: CGFloat, spacing: CGFloat) {
        self.imgStrings = imgStrings
        for (index, user) in imgStrings.enumerated() {
            if case .adv(_, _) = user.imageInfo[0] {
                // .reels 케이스가 있다면 해당 요소를 배열의 첫 번째로 이동시킴
                self.imgStrings.swapAt(2, index)
                break // 첫 번째 .reels 케이스를 발견했으므로 반복 중지
            }
        }
        self.viewWidth = viewWidth
        self.spacing = spacing
    }
    
    
    var body: some View {
        let smallItemWidth: CGFloat = (viewWidth - (2 * spacing)) / 3
        let height: CGFloat = smallItemWidth * 2 + spacing
        return HStack(spacing: spacing) {
            VStack(spacing: spacing) {
                if case let .feed(video, url) = imgStrings[0].imageInfo[0]  {
                    if video == true {

                    } else {
                        KFImage(URL(string:url)!)
                            .resizable()
                            .frame(width: smallItemWidth, height: smallItemWidth)
                            .scaledToFill()
                    }

                }
                if case let .feed(video, url) = imgStrings[1].imageInfo[0]  {
                    if video == true {

                    } else {
                        KFImage(URL(string:url)!)
                            .resizable()
                            .frame(width: smallItemWidth, height: smallItemWidth)
                            .scaledToFill()
                    }

                }

            }
            if case let .adv(video, url) = imgStrings[2].imageInfo[0]  {
                if video == true {

                } else {
                    KFImage(URL(string: url)!)
                        .resizable()
                        .frame(width: height, height: height)
                        .scaledToFill()
                }

            }

        }
        .frame(height: height)
   
    }
}


struct Layout3: View {
    var imgStrings: [ExploreViewUser]
    let viewWidth: CGFloat
    let spacing: CGFloat
    
    init(imgStrings: [ExploreViewUser], viewWidth: CGFloat, spacing: CGFloat) {
        self.imgStrings = imgStrings
        for (index, user) in imgStrings.enumerated() {
            if case .adv(_, _) = user.imageInfo[0] {
                // .reels 케이스가 있다면 해당 요소를 배열의 첫 번째로 이동시킴
                self.imgStrings.swapAt(0, index)
                break // 첫 번째 .reels 케이스를 발견했으므로 반복 중지
            }
        }
        self.viewWidth = viewWidth
        self.spacing = spacing
    }
    
    var body: some View {
        let smallItemWidth: CGFloat = (viewWidth - (2 * spacing)) / 3
        let height: CGFloat = smallItemWidth * 2 + spacing
        return HStack(spacing: spacing) {
            if case let .adv(video, url) = imgStrings[0].imageInfo[0]  {
                if video == true {

                } else {
                    KFImage(URL(string:url)!)
                        .resizable()
                        .frame(width: height, height: height)
                        .scaledToFill()
                }

            }
            
            

            VStack(spacing: spacing) {
                if case let .adv(video, url) = imgStrings[1].imageInfo[0]  {
                    if video == true {

                    } else {
                        KFImage(URL(string:url)!)
                            .resizable()
                            .frame(width: smallItemWidth, height: smallItemWidth)
                            .scaledToFill()
                    }

                }
                if case let .adv(video, url) = imgStrings[2].imageInfo[0]  {
                    if video == true {

                    } else {
                        KFImage(URL(string: url)!)
                            .resizable()
                            .frame(width: smallItemWidth, height: smallItemWidth)
                            .scaledToFill()
                    }

                }

            }

        }
        .frame(height: height)
   
    }
}

struct Layout4: View {
    var imgStrings: [ExploreViewUser]
    let viewWidth: CGFloat
    let spacing: CGFloat
    
    init(imgStrings: [ExploreViewUser], viewWidth: CGFloat, spacing: CGFloat) {
        self.imgStrings = imgStrings
        for (index, user) in imgStrings.enumerated() {
            if case .reels(_, _) = user.imageInfo[0] {
                // .reels 케이스가 있다면 해당 요소를 배열의 첫 번째로 이동시킴
                self.imgStrings.swapAt(0, index)
                break // 첫 번째 .reels 케이스를 발견했으므로 반복 중지
            }
        }
        self.viewWidth = viewWidth
        self.spacing = spacing
    }
    
    var body: some View {
        let smallItemWidth: CGFloat = (viewWidth - (2 * spacing)) / 3
        let height: CGFloat = smallItemWidth * 2 + spacing
        return HStack(spacing: spacing) {
            if case let .reels(_, url) = imgStrings[0].imageInfo[0]  {
                NavigationLink(destination: VideoView(player: AVPlayer(url: URL(string:url)!))) {
                    VideoPlayer(player: AVPlayer(url: URL(string:url)!))
                        .task {
                            _ = AVPlayer(url: URL(string:url)!)
                        }
                }
                
//                KFImage(URL(string: url)!)
//                    .resizable()
//                    .frame(width: smallItemWidth, height: height)
            }
            
            
                
            VStack(spacing: spacing) {
                if case let .feed(video, url) = imgStrings[1].imageInfo[0]  {
                    if video == true {
                        
                    }
                    else {
                        KFImage(URL(string: url)!)
                            .resizable()
                            .frame(width: smallItemWidth, height: smallItemWidth)
                            .scaledToFill()
                    }
                }
                if case let .feed(video, url) = imgStrings[2].imageInfo[0]  {
                    if video == true {
                        
                    }
                    else {
                        KFImage(URL(string: url)!)
                            .resizable()
                            .frame(width: smallItemWidth, height: smallItemWidth)
                            .scaledToFill()
                    }
                }
            }
            VStack(spacing: spacing) {
                if case let .feed(video, url) = imgStrings[3].imageInfo[0]  {
                    if video == true {
                        
                    }
                    else {
                        KFImage(URL(string: url)!)
                            .resizable()
                            .frame(width: smallItemWidth, height: smallItemWidth)
                            .scaledToFill()
                    }
                }
                if case let .feed(video, url) = imgStrings[4].imageInfo[0]  {
                    if video == true {
                        
                    }
                    else {
                        KFImage(URL(string: url)!)
                            .resizable()
                            .frame(width: smallItemWidth, height: smallItemWidth)
                            .scaledToFill()
                    }
                }
            }

        }
        .frame(height: height)
   
    }
}

struct Layout5: View {
    var imgStrings: [ExploreViewUser]
    let viewWidth: CGFloat
    let spacing: CGFloat
    
    init(imgStrings: [ExploreViewUser], viewWidth: CGFloat, spacing: CGFloat) {
        self.imgStrings = imgStrings
        for (index, user) in imgStrings.enumerated() {
            if case .reels(_, _) = user.imageInfo[0] {
                // .reels 케이스가 있다면 해당 요소를 배열의 첫 번째로 이동시킴
                self.imgStrings.swapAt(4, index)
                break // 첫 번째 .reels 케이스를 발견했으므로 반복 중지
            }
        }
        self.viewWidth = viewWidth
        self.spacing = spacing
    }
    
    var body: some View {
        let smallItemWidth: CGFloat = (viewWidth - (2 * spacing)) / 3
        let height: CGFloat = smallItemWidth * 2 + spacing
        return HStack(spacing: spacing) {
            
            

            VStack(spacing: spacing) {
                if case let .feed(video, url) = imgStrings[0].imageInfo[0]  {
                    if video == true {
                        
                    }
                    else {
                        KFImage(URL(string: url)!)
                            .resizable()
                            .frame(width: smallItemWidth, height: smallItemWidth)
                            .scaledToFill()
                    }
                }
                if case let .feed(video, url) = imgStrings[1].imageInfo[0]  {
                    if video == true {
                        
                    }
                    else {
                        KFImage(URL(string: url)!)
                            .resizable()
                            .frame(width: smallItemWidth, height: smallItemWidth)
                            .scaledToFill()
                    }
                }
            }
            VStack(spacing: spacing) {
                if case let .feed(video, url) = imgStrings[2].imageInfo[0]  {
                    if video == true {
                        
                    }
                    else {
                        KFImage(URL(string: url)!)
                            .resizable()
                            .frame(width: smallItemWidth, height: smallItemWidth)
                            .scaledToFill()
                    }
                }
                if case let .feed(video, url) = imgStrings[3].imageInfo[0]  {
                    if video == true {
                        
                    }
                    else {
                        KFImage(URL(string: url)!)
                            .resizable()
                            .frame(width: smallItemWidth, height: smallItemWidth)
                            .scaledToFill()
                    }
                }
            }
            if case let .reels(_, url) = imgStrings[4].imageInfo[0]  {
                NavigationLink(destination: VideoView(player: AVPlayer(url: URL(string:url)!))) {
                    VideoPlayer(player: AVPlayer(url: URL(string:url)!))
                        .task {
                            _ = AVPlayer(url: URL(string:url)!)
                        }.frame(width: smallItemWidth, height: height)
    //                KFImage(URL(string: url)!)
    //                    .resizable()
    //                    .frame(width: smallItemWidth, height: height)
    //                    .scaledToFill()
                }

            }

        }
        .frame(height: height)
   
    }
}

struct ExploreGrid_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}

//
//#Preview {
//    ExploreGrid()
//}
