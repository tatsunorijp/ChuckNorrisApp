//
//  RxExtensions.swift
//  BaseMVVM
//
//  Created by Wellington Tatsunori Asahide on 12/06/21.
//

import RxSwift
import RxCocoa

// MARK: - Codable Extensions

public extension PrimitiveSequence where Element == Data, Trait == SingleTrait {
    func decoded<T: Decodable>(to type: T.Type, using decoder: JSONDecoder = JSONDecoder()) -> Single<T> {
        return map { try decoder.decode(type, from: $0) }
    }
}

public extension PrimitiveSequence where Element: Encodable, Trait == SingleTrait {
    func encoded(using encoder: JSONEncoder = JSONEncoder()) -> Single<Data> {
        return map { try encoder.encode($0) }
    }
}

public extension ObservableType where Element == Data {
    func decoded<T: Decodable>(to type: T.Type, using decoder: JSONDecoder) -> Observable<T> {
        return map { try decoder.decode(type, from: $0) }
    }
}

public extension ObservableType where Element: Encodable {
    func encoded(using encoder: JSONEncoder = JSONEncoder()) -> Observable<Data> {
        return map { try encoder.encode($0) }
    }
}

public extension ObservableType where Element == Bool {
    func not() -> Observable<Bool> {
        return map(!)
    }
}

public extension ObservableType {
    // TODO: Acho que a seguinte função nunca será usada
//    func catchErrorJustComplete() -> Observable<Element> {
//        return catchError { _ in
//            return Observable.empty()
//        }
//    }

    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { _ in
            return Driver.empty()
        }
    }
    // MARK: Retirado de
    // https://stackoverflow.com/questions/55138672/rxswift-asdriveronerrorjustcomplete-not-being-part-of-core-utility-library
    func asDriverLogError(_ file: StaticString = #file, _ line: UInt = #line) -> SharedSequence<DriverSharingStrategy, Element> {
        return asDriver(onErrorRecover: { print("Error:", $0, " in file:", file, " atLine:", line); return .empty() })
    }

    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }

}

public extension PrimitiveSequence where Trait == SingleTrait {

    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { _ in
            return Driver.empty()
        }
    }
    
    // MARK: Retirado de
    // https://stackoverflow.com/questions/55138672/rxswift-asdriveronerrorjustcomplete-not-being-part-of-core-utility-library
    
    func asDriverLogError(_ file: StaticString = #file, _ line: UInt = #line) -> SharedSequence<DriverSharingStrategy, Element> {
        return asDriver(onErrorRecover: { print("Error:", $0, " in file:", file, " atLine:", line); return .empty() })
    }

    func mapToVoid() -> Single<Void> {
        return map { _ in }
    }

}

// MARK: - Optional Extensions

public protocol OptionalType {
    associatedtype Wrapped
    var optional: Wrapped? { get }
}

extension Optional: OptionalType {
    public var optional: Wrapped? { return self }
}

public extension Observable where Element: OptionalType {
    func skipNil() -> Observable<Element.Wrapped> {
        return flatMap { value in
            value.optional.map { Observable<Element.Wrapped>.just($0) } ?? Observable<Element.Wrapped>.empty()
        }
    }

    func whenNil(returns wrappedValue: Element.Wrapped) -> Observable<Element.Wrapped> {
        return flatMap { value in
            value.optional.map { Observable<Element.Wrapped>.just($0) } ??
                Observable<Element.Wrapped>.just(wrappedValue)
        }
    }
}

public extension SharedSequenceConvertibleType where Element: OptionalType {
    func skipNil() -> Driver<Element.Wrapped> {
        return flatMap { value in
            value.optional.map { Driver<Element.Wrapped>.just($0) } ?? Driver<Element.Wrapped>.empty()
        }
    }

    func whenNil(returns wrappedValue: Element.Wrapped) -> Driver<Element.Wrapped> {
        return flatMap { value in
            value.optional.map { Driver<Element.Wrapped>.just($0) } ?? Driver<Element.Wrapped>.just(wrappedValue)
        }
    }
}

extension Completable {
    // Mistura do activity + error tracker
    func asDriver(
        trackActivityWith activityTracker: ActivityIndicator,
        onErrorTrackWith errorTracker: ErrorTracker
    ) -> Driver<Void> {
        return andThen(Single.just(()))
            .trackActivity(activityTracker)
            .trackError(errorTracker)
            .asDriver(
                onErrorRecover: { _ in
                    .empty()
                }
            )
    }
}

extension Single {
    // Mistura do activity + error tracker
    func asDriver(
        trackActivityWith activityTracker: ActivityIndicator,
        onErrorTrackWith errorTracker: ErrorTracker
    ) -> Driver<Element> {
        return trackActivity(activityTracker)
            .trackError(errorTracker)
            .asDriver(
                onErrorRecover: { _ in
                    .empty()
                }
            )
    }

    // nunca usei
    func asDriver(
        onErrorTrackWith errorTracker: ErrorTracker
    ) -> Driver<Element> {
        return trackError(errorTracker)
            .asDriver(onErrorRecover: { _ in
                .empty()
            })
    }
}

extension ObservableType {
    // Mistura do activity + error tracker
    func asDriver(
        trackActivityWith activityTracker: ActivityIndicator,
        onErrorTrackWith errorTracker: ErrorTracker
    ) -> Driver<Element> {
        return trackActivity(activityTracker)
            .trackError(errorTracker)
            .asDriver(
                onErrorRecover: { _ in
                    .empty()
                }
            )
    }
}
