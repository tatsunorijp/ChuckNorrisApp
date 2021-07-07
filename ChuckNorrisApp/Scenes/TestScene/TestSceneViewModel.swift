//
//  TestSceneViewModel.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 07/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
// Ideia retirada de:
// https://github.com/tailec/ios-architecture/blob/master/mvvm-functions-subjects-observables/MVVMFunctionsSubjectsObservables/App/ReposScene/ReposViewModel.swift

import RxCocoa
import RxSwift

protocol TestSceneViewModelInput: AnyObject {}

protocol TestSceneViewModelOutput: AnyObject {}

protocol TestSceneViewModelType: AnyObject {
    var input: TestSceneViewModelInput { get }
    var output: TestSceneViewModelOutput { get }
}

final class TestSceneViewModel: TestSceneViewModelType, TestSceneViewModelInput, TestSceneViewModelOutput {
    
    init(interactor: TestSceneInteractable) {}

    var input: TestSceneViewModelInput { return self }
    var output: TestSceneViewModelOutput { return self }

}
