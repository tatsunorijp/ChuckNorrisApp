//
//  SearchFactsInteractorTests.swift
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

final class SearchFactsInteractorTests: XCTestCase {
    private var sut: SearchFactsInteractor!
    private var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        setupSearchFactsInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }

    private func setupSearchFactsInteractor() {
        disposeBag = DisposeBag()
    }

    func testExample() {}
}
