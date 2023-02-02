//
//  ListGenreEntity.swift
//  MovieApp-VIPER
//
//  Created by FauziArda on 21/01/23.
//

import Foundation


// MARK: - Genres
struct Genres: Codable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
