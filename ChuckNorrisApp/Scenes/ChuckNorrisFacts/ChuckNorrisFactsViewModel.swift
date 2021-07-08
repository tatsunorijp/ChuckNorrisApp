//
//  ChuckNorrisFactsViewModel.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 08/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
// Ideia retirada de:
// https://github.com/tailec/ios-architecture/blob/master/mvvm-functions-subjects-observables/MVVMFunctionsSubjectsObservables/App/ReposScene/ReposViewModel.swift

import RxCocoa
import RxSwift

protocol ChuckNorrisFactsViewModelInput: AnyObject {}

protocol ChuckNorrisFactsViewModelOutput: AnyObject {}

protocol ChuckNorrisFactsViewModelType: AnyObject {
    var input: ChuckNorrisFactsViewModelInput { get }
    var output: ChuckNorrisFactsViewModelOutput { get }
}

final class ChuckNorrisFactsViewModel: ChuckNorrisFactsViewModelType, ChuckNorrisFactsViewModelInput, ChuckNorrisFactsViewModelOutput {
    
    init(interactor: ChuckNorrisFactsInteractable) {}

    var input: ChuckNorrisFactsViewModelInput { return self }
    var output: ChuckNorrisFactsViewModelOutput { return self }

}
