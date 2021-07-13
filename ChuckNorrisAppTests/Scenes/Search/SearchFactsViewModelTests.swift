//
//  SearchFactsViewModelTests.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 13/07/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

@testable import ChuckNorrisApp
import RxCocoa
import RxSwift
import RxTest
import XCTest

final class SearchFactsViewModelTests: XCTestCase {
    private var sut: SearchFactsViewModel!
    private var disposeBag: DisposeBag!
    private var interactor: SearchFactsInteractableMock!

    private var isTermBiggerEnough: TestableObserver<Bool>!
    
    override func setUp() {
        super.setUp()
        setupSearchFactsViewModel()
    }

    override func tearDown() {
        super.tearDown()
    }

    private func setupSearchFactsViewModel() {
        disposeBag = DisposeBag()
        interactor = SearchFactsInteractableMock()
        sut = SearchFactsViewModel(interactor: interactor)
        
        let testScheduler = TestScheduler(initialClock: 0)
        
        isTermBiggerEnough = testScheduler.createObserver(Bool.self)
        sut.output.isTermBiggerEnough.drive(isTermBiggerEnough).disposed(by: disposeBag)
    }

    func test_shouldIsTermBiggerEnoughtToggle_whenTermChange() {
        sut.input.didSearchTermChange.onNext("aaa")
        sut.input.didSearchTermChange.onNext("aa")
        sut.input.didSearchTermChange.onNext("aaa")
        
        XCTAssertEqual(isTermBiggerEnough.events.compactMap { $0.value.element }, [
                        false, true, false, true
        ])
    }
}
