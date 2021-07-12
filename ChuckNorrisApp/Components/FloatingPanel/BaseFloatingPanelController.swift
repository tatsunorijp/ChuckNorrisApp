//
//  BaseFloatingPanel.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 12/07/21.
//

import UIKit
import FloatingPanel
import TinyConstraints

class BaseFloatingPanelController: FloatingPanelController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let grabberHandleView = FloatingPanelGrabberView()
        surfaceView.grabberHandle.isHidden = true
        surfaceView.addSubview(grabberHandleView)

        grabberHandleView.edges(to: surfaceView, excluding: .bottom)
        grabberHandleView.height(FloatingPanelGrabberView.Constants.height)
        surfaceView.appearance.cornerRadius = FloatingPanelGrabberView.Constants.height / 2
        surfaceView.contentPadding.top = FloatingPanelGrabberView.Constants.height
    }
}

class BaseFloatingPanelLayout: FloatingPanelLayout {
    var position: FloatingPanelPosition = .bottom
    var initialState: FloatingPanelState = .half
    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .half: FloatingPanelLayoutAnchor(fractionalInset: 0.5, edge: .bottom, referenceGuide: .safeArea)
        ]
    }

    func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        return 0.5
    }
}
