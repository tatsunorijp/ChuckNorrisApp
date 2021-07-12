//
//  ChuckNorrisFactsEmptyView.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 10/07/21.
//

import UIKit

final class ChuckNorrisFactsEmptyView: UIView {
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepare()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepare()
    }
    
    private func prepare() {
        label.text = L10n.ChuckNorrisFacts.EmptyView.label
        label.textColor = Asset.Colors.gray300.color
        label.textAlignment = .center
        label.numberOfLines = 0
        addSubview(label)
        label.leftToSuperview(offset: 32)
        label.rightToSuperview(offset: -32)
        label.edgesToSuperview(excluding: [.left, .right])
    }

}
