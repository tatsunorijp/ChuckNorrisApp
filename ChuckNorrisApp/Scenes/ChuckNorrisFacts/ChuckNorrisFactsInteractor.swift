//
//  ChuckNorrisFactsInteractor.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 08/07/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift

protocol ChuckNorrisFactsInteractable: AnyObject {
    func fetchFacts(searchTerm: String) -> Single<[Fact]>
}

final class ChuckNorrisFactsInteractor: ChuckNorrisFactsInteractable {
    struct ChuckNorrisFactMock: Equatable {
        let id: String
        let categories: [String]
        let iconURL: String
        let fact: String
    }
    
    func fetchFacts(searchTerm: String) -> Single<[Fact]> {
//        return .just([
//            ChuckNorrisFactMock(
//                id: UUID().uuidString,
//                categories: ["Animal"],
//                iconURL: "",
//                fact: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo"
//            ),
//            ChuckNorrisFactMock(
//                id: UUID().uuidString,
//                categories: ["Career"],
//                iconURL: "",
//                fact: "A wonderful serenity has taken possession of my entire soul, like these sweet mornings of spring which I enjoy with"
//            ),
//            ChuckNorrisFactMock(
//                id: UUID().uuidString,
//                categories: ["Celebrity"],
//                iconURL: "",
//                fact: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa."
//            ),
//            ChuckNorrisFactMock(
//                id: UUID().uuidString,
//                categories: ["Political"],
//                iconURL: "",
//                fact: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa"
//            ),
//            ChuckNorrisFactMock(
//                id: UUID().uuidString,
//                categories: ["Travel"],
//                iconURL: "",
//                fact: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo"
//            ),
//            ChuckNorrisFactMock(
//                id: UUID().uuidString,
//                categories: ["Fashion"],
//                iconURL: "",
//                fact: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor"
//            )
//        ]).delay(.seconds(2), scheduler: MainScheduler.instance)
        
        return ApiClient.getPosts(term: searchTerm)
            .map { $0.result }
            .asSingle()
    }
}
