//
//  ChuckNorrisFactDetailsBuilder.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 12/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ChuckNorrisFactDetailsBuildable: AnyObject {
    func build(fact: Fact) -> UIViewController
}

final class ChuckNorrisFactDetailsBuilder: Builder, ChuckNorrisFactDetailsBuildable {
    func build(fact: Fact) -> UIViewController {
        let interactor = ChuckNorrisFactDetailsInteractor()
        let viewModel = ChuckNorrisFactDetailsViewModel(interactor: interactor, fact: fact)
        let router = ChuckNorrisFactDetailsRouter()
        let viewController = ChuckNorrisFactDetailsViewController(withViewModel: viewModel, router: router)
        router.viewController = viewController

        return viewController
    }
}
