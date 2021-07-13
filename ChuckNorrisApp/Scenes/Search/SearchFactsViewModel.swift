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

protocol SearchFactsViewModelInput: AnyObject {
    var didSearchTermChange: PublishSubject<String> { get }
}

protocol SearchFactsViewModelOutput: AnyObject {
    var isTermBiggerEnough: Driver<Bool> { get }
}

protocol SearchFactsViewModelType: AnyObject {
    var input: SearchFactsViewModelInput { get }
    var output: SearchFactsViewModelOutput { get }
}

final class SearchFactsViewModel: SearchFactsViewModelType, SearchFactsViewModelInput, SearchFactsViewModelOutput {
    
    enum Consts {
        static let minimunTermSize = 3
    }
    
    var isTermBiggerEnough: Driver<Bool>
    
    init(interactor: SearchFactsInteractable) {
        isTermBiggerEnough = didSearchTermChange.asDriverOnErrorJustComplete()
            .map { $0.count >= Consts.minimunTermSize }
            .distinctUntilChanged()
            .startWith(false)
    }
    
    var didSearchTermChange: PublishSubject<String> = PublishSubject()

    var input: SearchFactsViewModelInput { return self }
    var output: SearchFactsViewModelOutput { return self }

}
