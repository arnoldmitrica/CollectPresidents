//
//  Presidents.swift
//  milestone3
//
//  Created by Arnold Mitricã on 15/11/2020.
//

import Foundation

struct President: Codable
{
    var number: Int
    var president: String
    var birth_year: Int
    var death_year: Int?
    var took_office: String
    var left_office: String?
    var party: String
    var image: String
}

//struct Presidents: Codable
//{
//    var allpresidents: [President]
//}
