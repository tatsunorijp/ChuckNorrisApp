//
//  DiffableBox.swift
//  ChuckNorrisApp
//
//  Created by Wellington Tatsunori Asahide on 07/07/21.
//
// Retirado de:
// https://github.com/Instagram/IGListKit/issues/35#issuecomment-277503724

import Foundation
import IGListKit

final class DiffableBox<T>: ListDiffable {
    
    let value: T
    let identifier: NSObjectProtocol
    let equal: (T, T) -> Bool
    
    init(value: T, identifier: NSObjectProtocol, equal: @escaping(T, T) -> Bool) {
        self.value = value
        self.identifier = identifier
        self.equal = equal
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return identifier
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let other = object as? DiffableBox<T> else {
            return false
        }

        return equal(value, other.value)
    }
}

extension DiffableBox: Equatable where T: Equatable {
    convenience init(value: T, identifier: NSObjectProtocol) {
        self.init(value: value, identifier: identifier, equal: ==)
    }

    static func == (lhs: DiffableBox<T>, rhs: DiffableBox<T>) -> Bool {
        return lhs.value == rhs.value
    }
}
