//
//  Popular.swift
//  GuilhermeTestApp
//
//  Created by Guilherme Sathler on 16/12/21.
//

import Foundation

struct Popular: Codable {
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
