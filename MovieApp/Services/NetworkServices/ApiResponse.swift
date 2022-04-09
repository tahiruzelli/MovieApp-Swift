//
//  ApiResponse.swift
//  MovieApp
//
//  Created by Tahir Uzelli on 9.04.2022.
//

import Foundation

struct ApiResponse <T: Decodable>: Decodable {
    let dates: Dates
    let page: Int
    let results: T?
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
