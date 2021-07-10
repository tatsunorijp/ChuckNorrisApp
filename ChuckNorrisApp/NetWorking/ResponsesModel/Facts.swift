//
//  Facts.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 10/07/21.
//

import Foundation

//struct Facts: Codable {
//    let total: Int
//    let result: [Fact]
//}
//
//struct Fact: Codable {
//    let categories: [String]
//    let created_at: String
//    let icon_url: String
//    let id: String
//    let updated_at: String
//    let url: String
//    let value: String
//}

class Facts: Codable {
    let total: Int
    let result: [Fact]

    init(total: Int, result: [Fact]) {
        self.total = total
        self.result = result
    }
}

// MARK: - Result
class Fact: Codable {
    let categories: [String]
    let createdAt: String
    let iconURL: String
    let id, updatedAt: String
    let url: String
    let value: String

    enum CodingKeys: String, CodingKey {
        case categories
        case createdAt
        case iconURL
        case id
        case updatedAt
        case url, value
    }

    init(categories: [String], createdAt: String, iconURL: String, id: String, updatedAt: String, url: String, value: String) {
        self.categories = categories
        self.createdAt = createdAt
        self.iconURL = iconURL
        self.id = id
        self.updatedAt = updatedAt
        self.url = url
        self.value = value
    }
}
