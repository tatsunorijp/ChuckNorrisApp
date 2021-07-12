//
//  Facts.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 10/07/21.
//

import Foundation

struct Facts: Codable {
    let total: Int
    let all: [Fact]
    
    enum CodingKeys: String, CodingKey {
        case total
        case all = "result"
    }

    init(total: Int, all: [Fact]) {
        self.total = total
        self.all = all
    }
}

// MARK: - All
struct Fact: Codable, Equatable {
    
    let categories: [String]
    let createdAt: String
    let iconURL: String
    let id, updatedAt: String
    let url: String
    let value: String

    enum CodingKeys: String, CodingKey {
        case categories
        case createdAt = "created_at"
        case iconURL = "icon_url"
        case id
        case updatedAt = "updated_at"
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
