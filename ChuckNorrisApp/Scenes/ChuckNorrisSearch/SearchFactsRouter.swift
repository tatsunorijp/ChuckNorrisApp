//
//  SearchFactsRouter.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 09/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchFactsRouting: AnyObject {
    // Declare methods to navigate to other scenes
    // func navigateToOtherScene()
}

final class SearchFactsRouter: Router, SearchFactsRouting {
    /* All the builders needed when navigating must be passed as parameters in the constructor.
     init(otherSceneBuilder: OtherSceneBuildable) {
     self.otherSceneBuilder = otherSceneBuilder
     }

     func navigateToOtherScene() {
     let otherScene = otherSceneBuilder.build()
     viewController.navigationController.pushViewController(otherScene, animated: true)
     }

     private let otherSceneBuilder: OtherSceneBuildable
     */
}
