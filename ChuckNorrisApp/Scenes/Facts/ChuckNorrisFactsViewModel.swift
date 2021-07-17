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
    var didSelectFactId: PublishSubject<String> { get }
}

protocol ChuckNorrisFactsViewModelOutput: AnyObject {
    var isLoading: Driver<Bool> { get }
    var error: Driver<Error> { get }
    var encounteredFacts: Driver<[ChuckNorrisFactsViewModel.DisplayableModel]> { get }
    var selectedFact: Driver<Fact> { get }
}

protocol ChuckNorrisFactsViewModelType: AnyObject {
    var input: ChuckNorrisFactsViewModelInput { get }
    var output: ChuckNorrisFactsViewModelOutput { get }
}

final class ChuckNorrisFactsViewModel: ChuckNorrisFactsViewModelType, ChuckNorrisFactsViewModelInput, ChuckNorrisFactsViewModelOutput {
    
    let isLoading: Driver<Bool>
    let error: Driver<Error>
    let encounteredFacts: Driver<[DisplayableModel]>
    var selectedFact: Driver<Fact>
    
    init(interactor: ChuckNorrisFactsInteractable) {
        let activityIndicator = ActivityIndicator()
        isLoading = activityIndicator.asDriver()
        
        let errorTracker = ErrorTracker()
        error = errorTracker.asDriver()
        
        let encounteredFactsResponse = didSearchTextChange.asDriverOnErrorJustComplete()
            .flatMap { searchTerm in
                interactor.fetchFacts(searchTerm: searchTerm)
                    .asDriver(trackActivityWith: activityIndicator, onErrorTrackWith: errorTracker)
            }
        
        encounteredFacts = encounteredFactsResponse
            .map { $0.map { factData in
                return DisplayableModel(
                    id: factData.id,
                    categories: factData.categories,
                    fact: factData.value
                )
            }}
        
        selectedFact = didSelectFactId.asDriverOnErrorJustComplete()
            .withLatestFrom(encounteredFactsResponse) { (selectedFactId: $0, facts: $1) }
            .map { selectedFactId, facts in
                facts.first(where: { $0.id == selectedFactId })
            }
            .skipNil()
    }
    
    var input: ChuckNorrisFactsViewModelInput { return self }
    var output: ChuckNorrisFactsViewModelOutput { return self }
    
    var didSearchTextChange: PublishSubject<String> = PublishSubject()
    var didSelectFactId: PublishSubject<String> = PublishSubject()
}

extension ChuckNorrisFactsViewModel {
    struct DisplayableModel: Equatable {
        let id: String
        let categories: [String]
        let fact: String
    }
}
