//
//  UserView.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/02/28.
//

import SwiftUI

struct MyView: View {
    var body: some View {
        NavigationView {
            // Your navigation view content goes here
        }
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Text("Button")
             }
         }
    }
}

#Preview {
    MyView()
}
