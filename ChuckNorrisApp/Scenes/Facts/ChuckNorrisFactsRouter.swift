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
    func createChuckNorrisFactDetailsWith(_ fact: Fact) -> ChuckNorrisFactDetailsViewController
}

final class ChuckNorrisFactsRouter: Router, ChuckNorrisFactsRouting {
    let searchFactsBuilder: SearchFactsBuildable
    let factDetailsBuilder: ChuckNorrisFactDetailsBuildable
    
    init(searchFactsBuilder: SearchFactsBuildable, factDetailsBuilder: ChuckNorrisFactDetailsBuildable) {
        self.searchFactsBuilder = searchFactsBuilder
        self.factDetailsBuilder = factDetailsBuilder
    }
    
    func navigateToSearch(delegate: SearchFactsDelegate) {
        let searchViewController = searchFactsBuilder.build() as! SearchFactsViewController
        searchViewController.setDelegate(delegate)
        viewController.navigationController?.pushViewController(
            searchViewController,
            animated: true
        )
    }
    
    func createChuckNorrisFactDetailsWith(_ fact: Fact) -> ChuckNorrisFactDetailsViewController {
        return factDetailsBuilder.build(fact: fact) as! ChuckNorrisFactDetailsViewController
    }
}
