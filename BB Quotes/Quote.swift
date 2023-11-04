//
//  Quote.swift
//  BB Quotes
//
//  Created by William Howze on 10/30/23.
//

import Foundation

struct Quote: Decodable {
    let quote: String
    let character: String
    let production: String
}
