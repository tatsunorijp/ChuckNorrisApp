//
//  SearchFactsViewModel.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 09/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
// Ideia retirada de:
// https://github.com/tailec/ios-architecture/blob/master/mvvm-functions-subjects-observables/MVVMFunctionsSubjectsObservables/App/ReposScene/ReposViewModel.swift

import RxCocoa
import RxSwift

protocol SearchFactsViewModelInput: AnyObject {}

protocol SearchFactsViewModelOutput: AnyObject {}

protocol SearchFactsViewModelType: AnyObject {
    var input: SearchFactsViewModelInput { get }
    var output: SearchFactsViewModelOutput { get }
}

final class SearchFactsViewModel: SearchFactsViewModelType, SearchFactsViewModelInput, SearchFactsViewModelOutput {
    
    init(interactor: SearchFactsInteractable) {}

    var input: SearchFactsViewModelInput { return self }
    var output: SearchFactsViewModelOutput { return self }

}
