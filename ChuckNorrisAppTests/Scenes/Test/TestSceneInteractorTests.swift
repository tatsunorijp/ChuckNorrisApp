//
//  TestSceneInteractorTests.swift
//  ChuckNorrisApp
//
//  Created by Wellington Tatsunori Asahide on 07/07/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

@testable import ChuckNorrisApp
import RxCocoa
import RxSwift
import RxTest
import XCTest

final class TestSceneInteractorTests: XCTestCase {
    private var sut: TestSceneInteractor!
    private var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        setupTestSceneInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }

    private func setupTestSceneInteractor() {
        disposeBag = DisposeBag()
    }

    func testExample() {}
}
