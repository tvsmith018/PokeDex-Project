//
//  PageModel.swift
//  Pokemon Table
//
//  Created by Consultant on 5/6/22.
//

import Foundation

struct PokemonList: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Basic_Data]
    
    
}

struct Basic_Data: Decodable {
    let name: String
    let url: String
}
