//
//  ChuckNorrisFactDetailsInteractorTests.swift
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

final class ChuckNorrisFactDetailsInteractorTests: XCTestCase {
    private var sut: ChuckNorrisFactDetailsInteractor!
    private var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        setupChuckNorrisFactDetailsInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }

    private func setupChuckNorrisFactDetailsInteractor() {
        disposeBag = DisposeBag()
    }

    func testExample() {}
}
