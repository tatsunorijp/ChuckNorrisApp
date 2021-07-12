//
//  SearchFactsRouter.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 09/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchFactsRouting: AnyObject {
    func popViewController()
}

final class SearchFactsRouter: Router, SearchFactsRouting {
    func popViewController() {
        viewController.navigationController?.popViewController(animated: true)
    }
}
