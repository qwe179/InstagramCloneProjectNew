//
//  SaveView.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/04/30.
//

import SwiftUI
import Kingfisher
struct SaveView: View {
    @Binding var isSavePressed: Bool
    @Binding var isSavePresent: Bool
    var imageURL: URL
    var body: some View {
        HStack {
            KFImage(imageURL)
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(RoundedRectangle(cornerRadius: 5))
            VStack {
                Text("저장됨")
                Text("비공개")
            }
            Spacer()
            Button(action: {
                isSavePressed.toggle()
                isSavePresent.toggle()
            }){
                Image(isSavePressed ? "save.fill" : "Save")
                    .frame(width: 10,height: 10)
            }
        }.padding()
        HStack {
            Text("컬렉션")
            Spacer()
            Text("새 컬렉션")
        }.padding()
        
  
    }
}


#Preview {
    FeedView()
}
