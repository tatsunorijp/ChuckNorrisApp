//
//  SearchFactsBuilder.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 09/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchFactsBuildable: AnyObject {
    func build() -> UIViewController
}

final class SearchFactsBuilder: Builder, SearchFactsBuildable {
    func build() -> UIViewController {
        let interactor = SearchFactsInteractor()
        let viewModel = SearchFactsViewModel(interactor: interactor)
        let router = SearchFactsRouter()
        let viewController = SearchFactsViewController(withViewModel: viewModel, router: router)
        router.viewController = viewController

        return viewController
    }
}
