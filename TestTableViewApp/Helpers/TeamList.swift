//
//  TeamList.swift
//  TestTableViewApp
//
//  Created by Preet on 2019-03-25.
//  Copyright © 2019 Preetinder Kaur. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let list = try? newJSONDecoder().decode(List.self, from: jsonData)

import Foundation

typealias TeamList = Team

struct Team: Codable {
    let wins, losses: Int
    let fullName: String
    let id: Int
    let players: [Player]
    
    enum CodingKeys: String, CodingKey {
        case wins, losses
        case fullName = "full_name"
        case id, players
    }
}

struct Player: Codable {
    let id: Int
    let firstName, lastName: String
    let position: Position
    let number: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case position, number
    }
}

enum Position: String, Codable {
    case c = "C"
    case f = "F"
    case fC = "F-C"
    case g = "G"
    case gF = "G-F"
    case pf = "PF"
    case pg = "PG"
    case sf = "SF"
    case sg = "SG"
}


