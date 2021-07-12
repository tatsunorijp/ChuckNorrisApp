//
//  ApiError.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 10/07/21.
//

import Foundation

enum ApiError: Error {
    case noInternetAccess
    case forbidden
    case notFound
    case badRequest
    case internalServerError
    case unexpected
}
