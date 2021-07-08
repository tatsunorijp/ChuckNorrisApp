//
//  BaseNavigationController.swift
//  BaseMVVM
//
//  Created by Tatsu on 28/06/21.
//

import UIKit

class NavigationController: UINavigationController {

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        modalPresentationStyle = .fullScreen
    }
}
