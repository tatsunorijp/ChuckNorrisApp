//
//  ChuckNorrisFactsInteractorTests.swift
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

final class ChuckNorrisFactsInteractorTests: XCTestCase {
    private var sut: ChuckNorrisFactsInteractor!
    private var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        setupChuckNorrisFactsInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }

    private func setupChuckNorrisFactsInteractor() {
        disposeBag = DisposeBag()
    }

    func testExample() {}
}
