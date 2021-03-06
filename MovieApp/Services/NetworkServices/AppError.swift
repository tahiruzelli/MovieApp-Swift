//
//  AppError.swift
//  MovieApp
//
//  Created by Tahir Uzelli on 9.04.2022.
//

import Foundation

enum AppError: LocalizedError {
    case errorDecoding
    case unknownError
    case invalidUrl
    case serverError(String)
    
    var errorDescription: String? {
        switch self {
        case .errorDecoding:
            return "Response could not be decoded"
        case .unknownError:
            return "Unknown Error"
        case .invalidUrl:
            return "Give me a valid URL"
        case .serverError(let error):
            return error
        }
    }
}

