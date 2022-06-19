//
//  UIStackView + Extensions.swift
//  BeautyFiles
//
//  Created by Matthew Sakhnenko on 18.06.2022.
//

import UIKit

extension UIStackView {
    static func getStackView(for cellType: Layout, spacing: CGFloat = 0) -> UIStackView {
        let stack = UIStackView()
        stack.axis = cellType == .grid ? .vertical : .horizontal
        stack.spacing = spacing
        stack.alignment = .center
        return stack
    }
}
