//
//  FetchController.swift
//  BB Quotes
//
//  Created by William Howze on 10/30/23.
//

import Foundation

struct FetchController {
    // create an enum to catch network errors.
    enum NetworkError: Error {
        case badURL, badResponse
    }
    // this is the base URL - we will use this for quotes and characters
    private let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    // async run in the backgroung. throws.. this function throws errors.
    func fetchQuote(from show: String) async throws -> Quote {
        let quoteURL = baseURL.appending(path: "quotes/random")
        var quoteComponents = URLComponents(url: quoteURL, resolvingAgainstBaseURL: true)
        let quoteQueryItem = URLQueryItem(name: "production", value: show.replaceSpaceWithPlus)
        quoteComponents?.queryItems = [quoteQueryItem]
        
        guard let fetchURL = quoteComponents?.url else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        let quote = try JSONDecoder().decode(Quote.self, from: data)
        
        return quote
    }
    
// https://breaking-bad-api-six.vercel.app/api/characters?name=Walter+White
    
    func fetchCharacter(_ name: String) async throws -> Character {
        // this appends "characters" to the the URL
        let characterURL = baseURL.appending(path: "characters")
        var characterComponents = URLComponents(url: characterURL, resolvingAgainstBaseURL: true)
        // this creates the ? for the query - name is the characters name from the struct and Walter White gets changed to Walter+White
        let characterQueryItem = URLQueryItem(name: "name", value: name.replaceSpaceWithPlus)
        characterComponents?.queryItems = [characterQueryItem]
        
        guard let fetchURL = characterComponents?.url else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: fetchURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let characters = try decoder.decode([Character].self, from: data)
        
        return characters[0]
    }
}
