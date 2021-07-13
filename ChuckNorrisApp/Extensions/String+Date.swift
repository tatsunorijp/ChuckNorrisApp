//
//  String+Date.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 13/07/21.
//

import Foundation

extension String {
    func toDate(using dateFormatter: DateFormatter) -> Date {
        dateFormatter.date(from: self) ?? Date()
    }
}
