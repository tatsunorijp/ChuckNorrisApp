//
//  DateFormatter.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 13/07/21.
//

import Foundation

extension DateFormatter {
    static func with(format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = enUsLocale
        formatter.timeZone = .current
        formatter.dateFormat = format
        return formatter
    }
    
    static let enUsLocale = Locale(identifier: "en_US")
    
    static let complete = DateFormatter.with(format: "yy MMM dd 'At' HH:mm")
    
    static let iso8601 = DateFormatter.with(format: "y-MM-dd H:m:ss.SSSSSS")
}
