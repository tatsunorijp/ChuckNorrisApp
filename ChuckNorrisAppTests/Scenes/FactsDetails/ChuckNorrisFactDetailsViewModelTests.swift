//
//  ChuckNorrisFactDetailsViewModelTests.swift
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

final class ChuckNorrisFactDetailsViewModelTests: XCTestCase {
    private var sut: ChuckNorrisFactDetailsViewModel!
    private var disposeBag: DisposeBag!
    private var interactor: ChuckNorrisFactDetailsInteractableMock!
    
    private var selectedFact: TestableObserver<ChuckNorrisFactDetailsViewModel.FactDisplayable>!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    private func setupWith(_ fact: Fact) {
        disposeBag = DisposeBag()
        interactor = ChuckNorrisFactDetailsInteractableMock()
        sut = ChuckNorrisFactDetailsViewModel(
            interactor: interactor,
            fact: Fact(categories: [],
                       createdAt: "",
                       iconURL: "",
                       id: "1",
                       updatedAt: "",
                       url: "",
                       value: "234"
            ))
        
        let testScheduler = TestScheduler(initialClock: 0)
        
        selectedFact = testScheduler.createObserver(ChuckNorrisFactDetailsViewModel.FactDisplayable.self)
        sut.output.selectedFact.drive(selectedFact).disposed(by: disposeBag)
    }
}
