//
//  CommentView.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/03/05.
//

import SwiftUI
import Kingfisher
struct CommentView: View {
    @ObservedObject var commentManager = CommentManager.shared
    
    
    
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
                ForEach(0..<commentManager.comments.count, id: \.self) { index in
                    
                    HStack {
                        KFImage(commentManager.comments[index].profile ?? URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRCYjAlbjgFOHGaDB6spLUd7gqSby8hMgdFg&usqp=CAU"))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .frame(width: 40, height: 40)
                        VStack(alignment: .leading){
                            HStack {
                                Text(commentManager.comments[index].author)
                                Text(commentManager.comments[index].Date)
                            }
                            HStack(alignment:.top) {
                                Text(commentManager.comments[index].comment)
                                Spacer()
                                VStack {
                                    Button(action:{
                                        commentManager.comments[index].isHeart.toggle()
                                        commentManager.comments[index].isHeart ? (commentManager.comments[index].numberOfLike += 1) : (commentManager.comments[index].numberOfLike -= 1)
                                        
                                    }){
                                        Image(commentManager.comments[index].isHeart ? .heartFill :.heart)
                                    }
                                    Text(String(commentManager.comments[index].numberOfLike))
                                }.frame(width: 40)
                            }
                            
                        }
                   
               
                    
                    }
                    
                }
            } .frame(height: UIScreen.main.bounds.height - 150)
            Spacer()
        }
     
    }
}

#Preview {
    CommentView()
}
