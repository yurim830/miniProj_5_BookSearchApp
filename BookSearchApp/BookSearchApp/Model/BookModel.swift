//
//  BookModel.swift
//  BookSearchApp
//
//  Created by 유림 on 5/8/24.
//

import Foundation

// MARK: - Library
struct Library: Decodable {
    let meta: Meta
    let documents: [Document]
}

// MARK: - Document
struct Document: Decodable {
    let authors: [String]
    let contents, datetime, isbn: String
    let price: Int
    let publisher: String
    let salePrice: Int
    let status: String
    let thumbnail: URL
    let title: String
    let translators: [String]
    let url: String

    enum CodingKeys: String, CodingKey {
        case authors, contents, datetime, isbn, price, publisher
        case salePrice = "sale_price"
        case status, thumbnail, title, translators, url
    }
}

// MARK: - Meta
struct Meta: Decodable {
    let isEnd: Bool
    let pageableCount, totalCount: Int

    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}
