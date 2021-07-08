//
//  ChuckNorrisFactsViewController.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 08/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
// Ideia retirada de:
// https://github.com/tailec/ios-architecture/blob/master/mvvm-functions-subjects-observables/MVVMFunctionsSubjectsObservables/App/ReposScene/ReposViewController.swift
import RxCocoa
import RxSwift
import UIKit

final class ChuckNorrisFactsViewController: BaseViewController {
    
    private let viewModel: ChuckNorrisFactsViewModelType
    private let router: ChuckNorrisFactsRouting

    init(withViewModel viewModel: ChuckNorrisFactsViewModelType, router: ChuckNorrisFactsRouting) {
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
    
    override func prepare() {
        super.prepare()
        title = L10n.ChuckNorrisFacts.title
        let searchButton = UIBarButtonItem(image: Asset.Assets.magnifier.image,
                                           style: .plain,
                                           target: self,
                                           action: #selector(navigateToSearch)
        )
        
        navigationItem.rightBarButtonItem = searchButton
    }
    
    @objc private func navigateToSearch() {
        
    }
}
