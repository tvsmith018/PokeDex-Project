//
//  NetworkManager.swift
//  Pokemon Table
//
//  Created by Consultant on 5/5/22.
//

import Foundation
import UIKit

class NetworkManager {
    
    let session: URLSession
    
    init(session: URLSession = URLSession.shared){
        self.session = session
    }
}

extension NetworkManager {
    
    func engagePokemon(poke_set: Int,completion: @escaping (Result<PokemonList, Error>) -> Void){
        
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?offset=\(poke_set)&limit=30") else {
            completion(.failure(NetworkError.badURL))
            return
        }
        
        self.session.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, !(200..<300).contains(httpResponse.statusCode) {
                completion(.failure(NetworkError.badServerResponse(httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.badData))
                return
            }
            
            do {
                let pokemonList = try JSONDecoder().decode(PokemonList.self, from: data)
                
                completion(.success(pokemonList))
            }
            catch {
                completion(.failure(NetworkError.decodeError("\(error)")))
            }
        }.resume()
    }
    
    func pokemon_attributes(url_string: String, completion: @escaping (Result<PokemonModel, Error>) -> Void){
        
        guard let url = URL(string: url_string) else {
                completion(.failure(NetworkError.badURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, !(200..<300).contains(httpResponse.statusCode) {
                completion(.failure(NetworkError.badServerResponse(httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.badData))
                return
            }
            
            do {
                let pokemonList = try JSONDecoder().decode(PokemonModel.self, from: data)
                
                completion(.success(pokemonList))
            }
            catch {
                completion(.failure(NetworkError.decodeError("\(error)")))
            }
            
        }
        
        task.resume()
    }
    
    func pokemon_image(url_string: String, completion: @escaping (Result<Data, Error>) -> Void){
        guard let url = URL(string: url_string) else {
                completion(.failure(NetworkError.badURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, !(200..<300).contains(httpResponse.statusCode) {
                completion(.failure(NetworkError.badServerResponse(httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.badData))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}
