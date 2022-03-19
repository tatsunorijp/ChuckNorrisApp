// Generated using Sourcery 1.3.4 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// Template copiado de:
// https://github.com/krzysztofzablocki/Sourcery
// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
import RxSwift
#elseif os(OSX)
import AppKit
#endif
















class ChuckNorrisFactDetailsInteractableMock: ChuckNorrisFactDetailsInteractable {

}
class ChuckNorrisFactsInteractableMock: ChuckNorrisFactsInteractable {

    //MARK: - fetchFacts

    var fetchFactsSearchTermCallsCount = 0
    var fetchFactsSearchTermCalled: Bool {
        return fetchFactsSearchTermCallsCount > 0
    }
    var fetchFactsSearchTermReceivedSearchTerm: String?
    var fetchFactsSearchTermReceivedInvocations: [String] = []
    var fetchFactsSearchTermReturnValue: Single<[Fact]>!
    var fetchFactsSearchTermClosure: ((String) -> Single<[Fact]>)?

    func fetchFacts(searchTerm: String) -> Single<[Fact]> {
        fetchFactsSearchTermCallsCount += 1
        fetchFactsSearchTermReceivedSearchTerm = searchTerm
        fetchFactsSearchTermReceivedInvocations.append(searchTerm)
        return fetchFactsSearchTermClosure.map({ $0(searchTerm) }) ?? fetchFactsSearchTermReturnValue
    }

}
class SearchFactsInteractableMock: SearchFactsInteractable {

}
