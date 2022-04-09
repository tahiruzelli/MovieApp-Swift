//
//  AsUrl.swift
//  MovieApp
//
//  Created by Tahir Uzelli on 9.04.2022.
//

import Foundation

extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}
