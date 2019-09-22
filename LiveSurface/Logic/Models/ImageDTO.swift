//
//  ImageDTO.swift
//  LiveSurface
//
//  Created by Ani Eduard on 22/09/2019.
//  Copyright © 2019 Ani Eduard. All rights reserved.
//

import Foundation

struct ImageDTO: Decodable, Identifiable {
    
    private enum CodingKeys: CodingKey {
        case index
        case name
        case number
        case image
        case category
        case version
    }
    
    var index: Int
    var name: String
    var number: String
    var image: String
    var category: String
    var version: String
    
    var id: Int { return index }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        index = try container.decode(Int.self, forKey: .index)
        name = try container.decode(String.self, forKey: .name)
        number = try container.decode(String.self, forKey: .number)
        image = try container.decode(String.self, forKey: .image)
        category = try container.decode(String.self, forKey: .category)
        version = try container.decode(String.self, forKey: .version)
    }
}
