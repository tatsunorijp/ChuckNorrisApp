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
        sut = ChuckNorrisFactDetailsViewModel(interactor: interactor, fact: fact)
        
        let testScheduler = TestScheduler(initialClock: 0)
        selectedFact = testScheduler.createObserver(ChuckNorrisFactDetailsViewModel.FactDisplayable.self)
        sut.output.selectedFact.drive(selectedFact).disposed(by: disposeBag)
    }
    
    func test_shouldSelectedFactReturn_withCorrectFormat_andBigFont() {
        setupWith(Fact(
                    categories: ["Alcohol"],
                    createdAt: "2020-01-05 13:42:25.628594",
                    iconURL: "",
                    id: "1",
                    updatedAt: "",
                    url: "",
                    value: "Chuck Norris > Superman"
        ))
        
        sut.input.onViewDidLoad.onNext(())
        
        XCTAssertEqual(selectedFact.events.compactMap { $0.value.element }, [
            ChuckNorrisFactDetailsViewModel.FactDisplayable(
                categorie: "Alcohol",
                discoveredIn: "20 Jan 05 At 13:42",
                value: "Chuck Norris > Superman",
                textSize: .big
            )
        ])
    }
    
    func test_shouldSelectedFactReturn_withCorrectFormat_withoutCategory() {
        setupWith(Fact(
                    categories: [],
                    createdAt: "2020-01-05 13:42:25.628594",
                    iconURL: "",
                    id: "1",
                    updatedAt: "",
                    url: "",
                    value: "Chuck Norris > Superman"
        ))
        
        sut.input.onViewDidLoad.onNext(())
        
        XCTAssertEqual(selectedFact.events.compactMap { $0.value.element }, [
            ChuckNorrisFactDetailsViewModel.FactDisplayable(
                categorie: "Uncategorizied",
                discoveredIn: "20 Jan 05 At 13:42",
                value: "Chuck Norris > Superman",
                textSize: .big
            )
        ])
    }
    
    func test_shouldSelectedFactReturn_withCorrectFormat_andSmallFont() {
        setupWith(Fact(
                    categories: ["Alcohol"],
                    createdAt: "2020-01-05 13:42:25.628594",
                    iconURL: "",
                    id: "1",
                    updatedAt: "",
                    url: "",
                    value: "0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 81"
        ))
        
        sut.input.onViewDidLoad.onNext(())
        
        XCTAssertEqual(selectedFact.events.compactMap { $0.value.element }, [
            ChuckNorrisFactDetailsViewModel.FactDisplayable(
                categorie: "Alcohol",
                discoveredIn: "20 Jan 05 At 13:42",
                value: "0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 81",
                textSize: .small
            )
        ])
    }
}
