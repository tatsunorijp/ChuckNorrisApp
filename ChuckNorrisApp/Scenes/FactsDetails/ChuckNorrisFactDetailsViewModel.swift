//
//  ChuckNorrisFactDetailsViewModel.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 12/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
// Ideia retirada de:
// https://github.com/tailec/ios-architecture/blob/master/mvvm-functions-subjects-observables/MVVMFunctionsSubjectsObservables/App/ReposScene/ReposViewModel.swift

import RxCocoa
import RxSwift

protocol ChuckNorrisFactDetailsViewModelInput: AnyObject {
    var onViewDidLoad: PublishSubject<Void> { get }
}

protocol ChuckNorrisFactDetailsViewModelOutput: AnyObject {
    var selectedFact: Driver<ChuckNorrisFactDetailsViewModel.FactDisplayable> { get }
}

protocol ChuckNorrisFactDetailsViewModelType: AnyObject {
    var input: ChuckNorrisFactDetailsViewModelInput { get }
    var output: ChuckNorrisFactDetailsViewModelOutput { get }
}

final class ChuckNorrisFactDetailsViewModel: ChuckNorrisFactDetailsViewModelType, ChuckNorrisFactDetailsViewModelInput, ChuckNorrisFactDetailsViewModelOutput {
    
    enum Consts {
        static let numberOfWordsBreakPoint = 80
    }
    
    var selectedFact: Driver<ChuckNorrisFactDetailsViewModel.FactDisplayable>
    
    init(interactor: ChuckNorrisFactDetailsInteractable, fact: Fact) {
        selectedFact = onViewDidLoad.asDriverOnErrorJustComplete()
            .map { _ in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "y-MM-dd H:m:ss.SSSSSS"
                
                if let date = dateFormatter.date(from: fact.createdAt) {
                    print(date)
                }
                
                return FactDisplayable(
                    categorie: fact.categories.first ?? "Uncategorizied",
                    discoveredIn: fact.createdAt,
                    value: fact.value,
                    textSize: fact.value.numberOfWords > Consts.numberOfWordsBreakPoint
                        ? .small
                        : .big
                )
            }
    }
    
    var onViewDidLoad: PublishSubject<Void> = PublishSubject()

    var input: ChuckNorrisFactDetailsViewModelInput { return self }
    var output: ChuckNorrisFactDetailsViewModelOutput { return self }

}

extension ChuckNorrisFactDetailsViewModel {
    struct FactDisplayable {
        let categorie: String
        let discoveredIn: String
        let value: String
        let textSize: TextSize
    }
    
    enum TextSize {
        case big
        case small
    }
}
