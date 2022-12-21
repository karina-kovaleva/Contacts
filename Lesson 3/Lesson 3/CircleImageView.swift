//
//  ProfileImageView.swift
//  Lesson 3
//
//  Created by Karina Kovaleva on 20.12.22.
//

import UIKit

class CircleImageView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .systemGray3
        let radius: CGFloat = self.bounds.size.width / 2.0
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}
