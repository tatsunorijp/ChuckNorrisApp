//
//  TestSceneViewController.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 07/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
// Ideia retirada de:
// https://github.com/tailec/ios-architecture/blob/master/mvvm-functions-subjects-observables/MVVMFunctionsSubjectsObservables/App/ReposScene/ReposViewController.swift
import RxCocoa
import RxSwift
import UIKit

final class TestSceneViewController: BaseViewController {
    
    private let viewModel: TestSceneViewModelType
    private let router: TestSceneRouting

    init(withViewModel viewModel: TestSceneViewModelType, router: TestSceneRouting) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
