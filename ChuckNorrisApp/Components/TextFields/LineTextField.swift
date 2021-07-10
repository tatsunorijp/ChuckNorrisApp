//
//  LineTextField.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 09/07/21.
//

import UIKit

class LineTextField: BaseTextField {
    private var borderLayer: CALayer?

    override func layoutSubviews() {
        super.layoutSubviews()
        let textFieldText = ((text ?? "").isEmpty ? (placeholder ?? "") : text!)
        borderLayer?.removeFromSuperlayer()
        setUnderLine(lineWidth: textFieldText.size().width * 2)
    }

    private func setUnderLine(lineWidth: CGFloat) {
        let border = CALayer()
        let width = CGFloat(1.5)
        let initialPosition = (frame.size.width - lineWidth) / 2
        border.borderColor = Asset.Colors.gray300.color.cgColor
        border.frame = CGRect(x: initialPosition, y: frame.size.height - width, width: lineWidth, height: frame.size.height)
        border.borderWidth = width
        layer.addSublayer(border)
        layer.masksToBounds = true
        borderLayer = border
    }

    override func prepareLayout() {
        borderStyle = .none
        textAlignment = .center
        textColor = Asset.Colors.orange300.color
        tintColor = Asset.Colors.orange400.color
        autocorrectionType = .no
        // TODO: em um projeto real deve existir um padrão de fontes (H1, H2, etc)
        font = font?.withSize(22)
    }
}
