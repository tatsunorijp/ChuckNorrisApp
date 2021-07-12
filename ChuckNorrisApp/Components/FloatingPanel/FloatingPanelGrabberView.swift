//
//  FloatingPanelGrabberView.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 12/07/21.
//

import UIKit

final class FloatingPanelGrabberView: UIView {
    enum Constants {
        static let height: CGFloat = 48
        static let grabberHeight: CGFloat = 6
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }

    private func setUp() {
        let grabber = UIView()
        grabber.backgroundColor = Asset.Colors.gray300.color
        grabber.layer.cornerRadius = Constants.grabberHeight / 2
        grabber.layer.masksToBounds = true

        addSubview(grabber)

        grabber.centerInSuperview()
        grabber.size(CGSize(width: 56, height: Constants.grabberHeight))
    }
}
