//
//  SettingView.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/04/30.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        VStack {
            Color(.white).frame(height: 20)
            HStack {
                Button(action: {
                    
                }){
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color(UIColor(hexString: "f7f7f7")))
                        VStack {
                            Image("Save")
                                .resizable()
                                .frame(width: 30,height: 30)
                                .foregroundColor(.black)
                            Text("저장")
                                .foregroundColor(.black)
                        }
                    }
                }.frame(height: 100)
                Button(action: {
                    
                }){
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color(UIColor(hexString: "f7f7f7")))
                        VStack {
                            Image(systemName: "qrcode.viewfinder")
                                .resizable()
                                .frame(width: 30,height: 30)
                                .foregroundColor(.black)
                            Text("QR 코드")
                                .foregroundColor(.black)
                            
                        }.padding()
                    }
                }.frame(height: 100)
            }
            VStack(spacing:0) {
                Button(action:{}) {
                    ZStack {
                          Rectangle()
                            .foregroundColor(Color(UIColor(hexString: "f7f7f7")))
                            .clipShape(
                                .rect(
                                    topLeadingRadius: 20,
                                    topTrailingRadius: 20
                                )
                            )
                            
                        HStack {
                            Image(systemName: "star")
                                .resizable()
                                .frame(width: 30,height: 30)
                                .foregroundColor(.black)
                            Text("즐겨찾기에 추가")
                                .foregroundColor(.black)
                            Spacer()
                        }.padding()
                 
                    }
                }
                Divider()
                Button(action:{}) {
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color(UIColor(hexString: "f7f7f7")))
                            .clipShape(
                                .rect(
                                    bottomLeadingRadius: 20,
                                    bottomTrailingRadius: 20
                                )
                            )
                        HStack {
                            Image(systemName: "person.badge.minus")
                                .resizable()
                                .frame(width: 30,height: 30)
                                .foregroundColor(.black)
                            Text("팔로우 취소")
                                .foregroundColor(.black)
                            Spacer()
                        }.padding()
                 
                    }
                }
            }
            VStack(spacing:0) {
                Button(action:{}) {
                    ZStack {
                          Rectangle()
                            .foregroundColor(Color(UIColor(hexString: "f7f7f7")))
                            .clipShape(
                                .rect(
                                    topLeadingRadius: 20,
                                    topTrailingRadius: 20
                                )
                            )
                            
                        HStack {
                            Image(systemName: "person.circle")
                                .resizable()
                                .frame(width: 30,height: 30)
                                .foregroundColor(.black)
                            Text("이 계정 정보")
                                .foregroundColor(.black)
                            Spacer()
                        }.padding()
                 
                    }
                }
                Divider()
                Button(action:{}) {
                    ZStack {
                          Rectangle()
                            .foregroundColor(Color(UIColor(hexString: "f7f7f7")))
                        HStack {
                            Image(systemName: "info.circle")
                                .resizable()
                                .frame(width: 30,height: 30)
                                .foregroundColor(.black)
                            Text("이 게시물이 표시되는 이유")
                                .foregroundColor(.black)
                            Spacer()
                        }.padding()
                 
                    }
                }
                Divider()
                Button(action:{}) {
                    ZStack {
                          Rectangle()
                            .foregroundColor(Color(UIColor(hexString: "f7f7f7")))
                        HStack {
                            Image(systemName: "eye.slash")
                                .resizable()
                                .frame(width: 30,height: 30)
                                .foregroundColor(.black)
                            Text("숨기기")
                                .foregroundColor(.black)
                            Spacer()
                        }.padding()
                 
                    }
                }
                Divider()
                Button(action:{}) {
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color(UIColor(hexString: "f7f7f7")))
                            .clipShape(
                                .rect(
                                    bottomLeadingRadius: 20,
                                    bottomTrailingRadius: 20
                                )
                            )
                        HStack {
                            Image(systemName: "exclamationmark.bubble")
                                .resizable()
                                .frame(width: 30,height: 30)
                                .foregroundColor(.red)
                            Text("신고")
                                .foregroundColor(.black)
                            Spacer()
                        }.padding()
                 
                    }
                }
            }

        }
    
    }
}

#Preview {
    SettingView()
}
