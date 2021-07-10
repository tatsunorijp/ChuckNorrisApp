//
//  LoadingView.swift
//  BaseMVVM
//
//  Created by Wellington Tatsunori Asahide on 12/06/21.
//

import UIKit
import TinyConstraints

class LoadingView: UIViewController {
    private let activityIndicator = UIActivityIndicatorView()
    private let blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        return blurEffectView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepare()
        activityIndicator.startAnimating()
    }
    
    private func prepare() {
        view.addSubview(blurView)
        blurView.edgesToSuperview()
        
        view.addSubview(activityIndicator)
        activityIndicator.edgesToSuperview()
        activityIndicator.color = Asset.Colors.orange300.color
    }
}
