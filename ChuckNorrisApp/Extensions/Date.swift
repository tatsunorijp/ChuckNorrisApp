//
//  Date.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 13/07/21.
//

import Foundation

extension Date {
    func formatted(using dateFormatter: DateFormatter) -> String {
        dateFormatter.string(from: self)
    }
}
