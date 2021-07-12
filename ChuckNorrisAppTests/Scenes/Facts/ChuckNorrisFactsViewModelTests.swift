//
//  ChuckNorrisFactsViewModelTests.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 12/07/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

@testable import ChuckNorrisApp
import RxCocoa
import RxSwift
import RxTest
import XCTest

final class ChuckNorrisFactsViewModelTests: XCTestCase {
    private var sut: ChuckNorrisFactsViewModel!
    private var disposeBag: DisposeBag!
    private var interactor: ChuckNorrisFactsInteractableMock!
    
    var isLoading: TestableObserver<Bool>!
    var error: TestableObserver<Error>!
    var encounteredFacts: TestableObserver<[ChuckNorrisFactsViewModel.DisplayableModel]>!
    var selectedFact: TestableObserver<Fact>!
    
    override func setUp() {
        super.setUp()
        setupChuckNorrisFactsViewModel()
    }

    override func tearDown() {
        super.tearDown()
    }

    private func setupChuckNorrisFactsViewModel() {
        disposeBag = DisposeBag()
        interactor = ChuckNorrisFactsInteractableMock()
        sut = ChuckNorrisFactsViewModel(interactor: interactor)
        
        let testScheduler = TestScheduler(initialClock: 0)
        
        isLoading = testScheduler.createObserver(Bool.self)
        sut.output.isLoading.drive(isLoading).disposed(by: disposeBag)
        
        error = testScheduler.createObserver(Error.self)
        sut.output.error.drive(error).disposed(by: disposeBag)
        
        encounteredFacts = testScheduler.createObserver([ChuckNorrisFactsViewModel.DisplayableModel].self)
        sut.output.encounteredFacts.drive(encounteredFacts).disposed(by: disposeBag)
        
        selectedFact = testScheduler.createObserver(Fact.self)
        sut.output.selectedFact.drive(selectedFact).disposed(by: disposeBag)
        
    }

    func test_isLoadingShouldToggle() {
        interactor.fetchFactsSearchTermReturnValue = .just(
            ChuckNorrisFactsViewModelTests.facts
        )
        sut.input.didSearchTextChange.onNext("a")
        
        XCTAssertEqual(isLoading.events.compactMap { $0.value.element }, [ false, true, false ])
    }
    
    func test_errorShouldReturn() {
        let expectedError = NSError(domain: "", code: 0, userInfo: nil)
        interactor.fetchFactsSearchTermReturnValue = .error(expectedError)
        sut.input.didSearchTextChange.onNext("a")
        
        XCTAssertEqual(error.events.compactMap { $0.value.element as NSError?}, [expectedError])
    }
    
    func test_encounteredFactsShoulReturn_with_correctFormat() {
        interactor.fetchFactsSearchTermReturnValue = .just(
            ChuckNorrisFactsViewModelTests.facts
        )
        sut.input.didSearchTextChange.onNext("a")
        
        XCTAssertEqual(encounteredFacts.events.compactMap { $0.value.element }, [
            ChuckNorrisFactsViewModelTests.expectedDisplayableFacts
        ])
    }
    
    func test_selectedFactShouldReturn_id_from_selectedFact() {
        interactor.fetchFactsSearchTermReturnValue = .just(
            ChuckNorrisFactsViewModelTests.facts
        )
        sut.input.didSearchTextChange.onNext("a")
        sut.input.didSelectFactId.onNext("1")
        
        XCTAssertEqual(selectedFact.events.compactMap { $0.value.element }, [
            ChuckNorrisFactsViewModelTests.facts[0]
        ])
    }
}

extension ChuckNorrisFactsViewModelTests {
    static let facts = [
        Fact(
            categories: [],
            createdAt: "",
            iconURL: "",
            id: "1",
            updatedAt: "",
            url: "",
            value: "fato1"
        ),
        Fact(
            categories: [],
            createdAt: "",
            iconURL: "",
            id: "2",
            updatedAt: "",
            url: "",
            value: "fato2"
        ),
        Fact(
            categories: [],
            createdAt: "",
            iconURL: "",
            id: "3",
            updatedAt: "",
            url: "",
            value: "fato3"
        )
    ]
    
    static let expectedDisplayableFacts = [
        ChuckNorrisFactsViewModel.DisplayableModel(
            id: "1",
            categories: [],
            fact: "fato1"
        ),
        ChuckNorrisFactsViewModel.DisplayableModel(
            id: "2",
            categories: [],
            fact: "fato2"
        ),
        ChuckNorrisFactsViewModel.DisplayableModel(
            id: "3",
            categories: [],
            fact: "fato3"
        )
    ]
}
