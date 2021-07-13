//
//  PrimaryButton.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 09/07/21.
//

import UIKit

class PrimaryButton: BaseButton {
    private let defaultHeight = CGFloat(44)
    
    override var isEnabled: Bool {
        didSet {
            if self.isEnabled {
                backgroundColor = Asset.Colors.orange400.color
            } else {
                backgroundColor = Asset.Colors.gray300.color
            }
        }
    }
    
    override func prepareLayout() {
        super.prepareLayout()
        frame.size = CGSize(width: frame.size.width, height: defaultHeight)
        layer.cornerRadius = frame.size.height / 2
        layer.masksToBounds = true
        clipsToBounds = true
        setTitleColor(Asset.Colors.white.color, for: .normal)
        
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
}
