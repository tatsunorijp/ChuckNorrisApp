//
//  RoundedTextField.swift
//  BaseMVVM
//
//  Created by Wellington Tatsunori Asahide on 25/06/21.
//

import Foundation
import UIKit

class RoundedTextField: BaseTextField {
    private let defaultHeight = CGFloat(40)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        frame.size.height = defaultHeight
        
        borderStyle = .none
        layer.cornerRadius = defaultHeight / 2
        layer.borderWidth = 0.5
    }
}
