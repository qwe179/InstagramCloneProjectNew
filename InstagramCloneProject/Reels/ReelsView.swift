//
//  LikeView.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/02/28.
//

import SwiftUI
import AVKit

struct ReelsView: View {
    @ObservedObject var reelsViewModel: ReelsViewModel = ReelsViewModel()
    @State var currentReel = ""
//    @State var reels = MediaFileJSON.map { item -> Reel in
//        guard let url = URL(string: item.url) else {return Reel(player: nil, mediafile: item) }
//        let player = AVPlayer(url: url)
//        return Reel(player: player, mediafile: item)
//    }
    
    var body: some View {
        GeometryReader{ proxy in
            let size = proxy.size
            TabView(selection: $currentReel) {
//                ForEach($reels) { $reels in
                ForEach(0..<reelsViewModel.reels.count, id: \.self) { index in
                    ReelsPlayer(reel: reelsViewModel.reels[index],currentReel: $currentReel)
                        .frame(
                             width: size.width,
                             height: size.height
                         )
                        .rotationEffect(.init(degrees: -90))
                        .ignoresSafeArea(.all, edges: .top)
                        .tag(reelsViewModel.reels[index].id)
                }
            }.rotationEffect(.init(degrees: 90))
                .frame(width: proxy.size.height)
                .frame(width: size.width)

                .tabViewStyle(.page(indexDisplayMode: .never))
               
        }
        .ignoresSafeArea(.all, edges: .top)
        .background(Color.black.ignoresSafeArea())
        .onAppear{
            currentReel = reelsViewModel.reels.first?.id ?? ""
        }
    }
}

struct ReelsPlayer: View{
    var reel: Reel
    @Binding var currentReel: String
    @State var isPlaying: Bool = true
    var body: some View{
        ZStack {
            if let player = reel.player {
                MyVideoPlayer(player: player)
                    .onTapGesture {
                        isPlaying.toggle()
                    }.onAppear {
                        isPlaying = true
                    }
                GeometryReader{ proxy -> Color in
                    let minY = proxy.frame(in: .global ).minY
                    let size = proxy.size
                    
                    DispatchQueue.main.async {
                        if -minY < (size.height / 2)
                                && minY < (size.height / 2)
                                && currentReel == reel.id {
                            player.play()
                        }
                        else {
                            player.pause()
                            player.seek(to: .zero)
                        }
                        if isPlaying == false {
                            player.pause()
                        }
                    }
                    return Color.clear
                }

                VStack {
                    HStack(alignment: .bottom){
                        VStack(alignment: .leading, spacing: 10) {
                            HStack(spacing:10) {
                                Image(reel.user.userProfile)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width:35, height: 35)
                                    .clipShape(Circle())
                                Text(reel.user.userName)
                                    .font(.callout.bold())
                            }
                            .padding(.top, 700)
                        }
                        Spacer(minLength: 20)
                        ActionButtons(reel: reel)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 20 )
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .bottom)
                
                if !isPlaying {
                    Button {
                        player.play()
                        isPlaying = true
                    } label: {
                        Image(systemName: "play.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
}

struct ActionButtons: View {
    var reel: Reel
    
    var body: some View {
        VStack(spacing: 25) {
            Button{
            }label: {
                VStack(spacing: 10) {
                    Image(systemName: "suit.heart")
                        .font(.title3)
                    Text("\(reel.user.heartNum)")
                        .font(.caption.bold())
                }
            }
            Button{
            }label: {
                VStack(spacing: 10) {
                    Image(systemName: "bubble.right.fill")
                        .font(.title3)
                    Text("\(reel.user.commentNum)")
                        .font(.caption.bold())
                }
            }
            Button{
            }label: {
                VStack(spacing: 10) {
                    Image(systemName: "paperplane.fill")
                        .font(.title3)
                }
            }
            Button{
            }label: {
                VStack(spacing: 10) {
                    Image(.moreIcon)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20,height: 20)
                }
            }
            
        }
    }
}

struct ReelView: View {
    let reel: Reel
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text(reel.title)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding()
        }
    }
}

struct MyVideoPlayer: UIViewControllerRepresentable {
    var player: AVPlayer
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent:self)
    }
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        controller.videoGravity = .resizeAspectFill
        player.actionAtItemEnd = .none
        NotificationCenter.default.addObserver(context.coordinator, selector: #selector(context.coordinator.restartPlayback), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
    }
    
    class Coordinator: NSObject{
        var parent: MyVideoPlayer

        init(parent: MyVideoPlayer) {
            self.parent = parent
        }
        @objc func restartPlayback() {
            parent.player.seek(to: .zero)
        }
    }
}

#Preview {
    HomeView()
}
