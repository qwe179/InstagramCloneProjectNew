//
//  CommentView.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/03/05.
//

import SwiftUI
import Kingfisher
struct CommentView: View {
    var body: some View {

        VStack {
            ZStack {
                Text("댓글")
                HStack{
                    Spacer()
                    Image(.dm)
                }.padding(.trailing)
                .padding(.leading)
            }
            Divider()
            List {
                Text("이미지입니다")
                Text("이미지입니다2")
                Text("이미지입니다3")
                Text("이미지입니다4")
            } .frame(height: UIScreen.main.bounds.height - 150)
            Spacer()
        }
     
    }
}

#Preview {
    CommentView()
}
