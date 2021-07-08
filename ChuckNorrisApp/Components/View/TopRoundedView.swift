//
//  TopRoundedView.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 08/07/21.
//

import UIKit

class TopRoundedView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepare()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepare()
    }

    private func prepare() {
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.cornerRadius = 35
        layer.masksToBounds = true
        backgroundColor = Asset.Colors.white.color
    }
}
