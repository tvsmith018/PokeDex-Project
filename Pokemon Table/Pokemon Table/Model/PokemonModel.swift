//
//  PokemonModel.swift
//  Pokemon Table
//
//  Created by Consultant on 5/6/22.
//

import Foundation

struct PokemonModel: Decodable{
    let abilities: [Ability]
    let base_experience: Int
    let forms: [Basic_Data]
    let game_indices: [GameIndex]
    let height: Int
    let held_items: [HeldItem]
    let id: Int
    let is_default: Bool
    let location_area_encounters: String
    let moves: [Move]
    let name: String
    let order: Int
    let past_types: [Basic_Data]
    let species: Basic_Data
    let sprites: Sprites
    let stats: [Stat]
    let types: [Types]
    let weight: Int
}

struct Ability: Decodable {
    let ability: Basic_Data
    let is_hidden: Bool
    let slot: Int
}

struct GameIndex: Decodable {
    let game_index: Int
    let version: Basic_Data
}

struct HeldItem: Decodable {
    let item: Basic_Data
    let version_details: [VersionDetails]
}

struct VersionDetails: Decodable {
    let rarity: Int
    let version: Basic_Data
}

struct Move: Decodable {
    let move: Basic_Data
    //let version_group_details: [VersionGroupDetails]
}

struct VersionGroupDetails: Decodable {
    let level_learned_at: Int
    let move_learn_method: Basic_Data
    let version_group: Basic_Data
}

struct Sprites: Decodable {
    let back_default: String?
    let back_female: String?
    let back_shiny: String?
    let back_shiny_female: String?
    let front_default: String?
    let front_female: String?
    let front_shiny: String?
    let front_shiny_female: String?
    //let other: OtherData
}

struct OtherData: Decodable {
    let dream_world: DreamWorld
    let home: Home
}

struct DreamWorld: Decodable {
    let front_default: String?
    let front_female: String?
}

struct Home: Decodable {
    let front_default: String?
    let front_female: String?
    let front_shiny: String?
    let front_shiny_female: String?
}

struct Stat: Decodable {
    let base_stat: Int
    let effort: Int
    let stat: Basic_Data
    
}

struct Types: Decodable{
    let slot: Int
    let type: Basic_Data
}
