//
//  ChuckNorrisFactsBuilder.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 08/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ChuckNorrisFactsBuildable: AnyObject {
    func build() -> UIViewController
}

final class ChuckNorrisFactsBuilder: Builder, ChuckNorrisFactsBuildable {
    func build() -> UIViewController {
        let interactor = ChuckNorrisFactsInteractor()
        let viewModel = ChuckNorrisFactsViewModel(interactor: interactor)
        let router = ChuckNorrisFactsRouter()
        let viewController = ChuckNorrisFactsViewController(withViewModel: viewModel, router: router)
        router.viewController = viewController

        return viewController
    }
}
