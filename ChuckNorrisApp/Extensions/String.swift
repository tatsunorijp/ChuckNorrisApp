//
//  Strings.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 08/07/21.
//

import Foundation

extension String {
    var numberOfWords: Int {
        return components(separatedBy: .whitespacesAndNewlines)
            .filter { !$0.isEmpty }
            .count
    }
}
