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

protocol ChuckNorrisFactsViewModelInput: AnyObject {
    var didSearchTextChange: PublishSubject<String> { get }
}

protocol ChuckNorrisFactsViewModelOutput: AnyObject {
    var isLoading: Driver<Bool> { get }
    var error: Driver<Error> { get }
    var encounteredFacts: Driver<[ChuckNorrisFactsViewModel.DisplayableModel]> { get }
}

protocol ChuckNorrisFactsViewModelType: AnyObject {
    var input: ChuckNorrisFactsViewModelInput { get }
    var output: ChuckNorrisFactsViewModelOutput { get }
}

final class ChuckNorrisFactsViewModel: ChuckNorrisFactsViewModelType, ChuckNorrisFactsViewModelInput, ChuckNorrisFactsViewModelOutput {
    
    enum Consts {
        static let quantityWordsBreakPoint = 80
    }
    
    let isLoading: Driver<Bool>
    let error: Driver<Error>
    let encounteredFacts: Driver<[DisplayableModel]>
    
    init(interactor: ChuckNorrisFactsInteractable) {
        let activityIndicator = ActivityIndicator()
        isLoading = activityIndicator.asDriver()
        
        let errorTracker = ErrorTracker()
        error = errorTracker.asDriver()
        
        encounteredFacts = didSearchTextChange.asDriverOnErrorJustComplete()
            .flatMap { searchTerm in
                interactor.fetchFacts()
                    .asDriver(trackActivityWith: activityIndicator, onErrorTrackWith: errorTracker)
            }
            .map { $0.map { factData in
                return DisplayableModel(
                    id: factData.id,
                    categories: factData.categories,
                    iconURL: factData.iconURL,
                    fact: factData.fact,
                    textSize: factData.fact.numberOfWords > Consts.quantityWordsBreakPoint
                        ? .small
                        : .large
                )
            }}
    }

    var input: ChuckNorrisFactsViewModelInput { return self }
    var output: ChuckNorrisFactsViewModelOutput { return self }

    var didSearchTextChange: PublishSubject<String> = PublishSubject()
}

extension ChuckNorrisFactsViewModel {
    struct DisplayableModel: Equatable {
        let id: String
        let categories: [String]
        let iconURL: String
        let fact: String
        let textSize: TextSize
    }
    
    enum TextSize {
        case small
        case large
    }
}
