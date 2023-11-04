//
//  Character.swift
//  BB Quotes
//
//  Created by William Howze on 10/30/23.
//

import Foundation

struct Character: Decodable {
    let name: String
    let birthday:  String
    let occupations: [String]
    let images: [URL]
    let aliases: [String]
    let portrayedBy: String
}
