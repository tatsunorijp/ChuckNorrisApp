//
//  ChuckNorrisFactsRouter.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 08/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ChuckNorrisFactsRouting: AnyObject {
    func navigateToSearch(delegate: SearchFactsDelegate)
}

final class ChuckNorrisFactsRouter: Router, ChuckNorrisFactsRouting {
    let searchFactsBuilder: SearchFactsBuildable
    
    init(searchFactsBuilder: SearchFactsBuildable) {
        self.searchFactsBuilder = searchFactsBuilder
    }
    
    func navigateToSearch(delegate: SearchFactsDelegate) {
        let searchViewController = searchFactsBuilder.build() as! SearchFactsViewController
        searchViewController.setDelegate(delegate)
        viewController.navigationController?.pushViewController(
            searchViewController,
            animated: true
        )
    }
}
