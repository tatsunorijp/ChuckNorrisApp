//
//  TestSceneBuilder.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 07/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol TestSceneBuildable: AnyObject {
    func build() -> UIViewController
}

final class TestSceneBuilder: Builder, TestSceneBuildable {
    func build() -> UIViewController {
        let interactor = TestSceneInteractor()
        let viewModel = TestSceneViewModel(interactor: interactor)
        let router = TestSceneRouter()
        let viewController = TestSceneViewController(withViewModel: viewModel, router: router)
        router.viewController = viewController

        return viewController
    }
}
