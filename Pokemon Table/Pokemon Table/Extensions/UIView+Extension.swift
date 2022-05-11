//
//  File.swift
//  Pokemon Table
//
//  Created by Consultant on 5/9/22.
//

import UIKit

extension UIView {
    
    convenience init(resistancePriority: UILayoutPriority, huggingPriority: UILayoutPriority) {
        self.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setContentHuggingPriority(huggingPriority, for: .vertical)
        self.setContentHuggingPriority(huggingPriority, for: .horizontal)
        self.setContentCompressionResistancePriority(resistancePriority, for: .vertical)
        self.setContentCompressionResistancePriority(resistancePriority, for: .horizontal)
        self.backgroundColor = .clear
    }
    
//    func createBufferView() -> UIView {
//
//    }
    
    
}
