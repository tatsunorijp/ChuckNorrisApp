//
//  ChuckNorrisFactsInteractor.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 08/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift

// sourcery: AutoMockable
protocol ChuckNorrisFactsInteractable: AnyObject {
    func fetchFacts(searchTerm: String) -> Single<[Fact]>
}

final class ChuckNorrisFactsInteractor: ChuckNorrisFactsInteractable {
    func fetchFacts(searchTerm: String) -> Single<[Fact]> {
        return ApiClient.getPosts(term: searchTerm)
            .map { $0.all }
            .asSingle()
    }
}
