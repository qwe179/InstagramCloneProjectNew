//
//  CustomSpinner.swift
//  InstagramCloneProject
//
//  Created by 23 09 on 2024/03/25.
//

import UIKit

class SingletonView: UIView {
// Singleton instance
    static let shared : UIView =
SingletonView.sharedInstance(size: CGSize(width: 20, height: 20))

    // You can modify argument list as per your need.
    class private func sharedInstance(size : CGSize)->UIView {
        //Putting the view in the middle, but the details falls on you.
        let view = UIView(frame: CGRect(x: (UIScreen.main.bounds.width / 2) - 10, y: 0, width: size.width, height: size.height))
  //just so you can see something
    view.backgroundColor = .clear
        return view
    }
}
