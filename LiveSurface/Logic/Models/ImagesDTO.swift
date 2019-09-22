//
//  ImagesDTO.swift
//  LiveSurface
//
//  Created by Ani Eduard on 22/09/2019.
//  Copyright © 2019 Ani Eduard. All rights reserved.
//

import Foundation

struct ImagesDTO: Decodable {
    
    private enum CodingKeys: CodingKey {
        case images
    }
    
    var images: [ImageDTO] = []
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        images = try container.decode([String: ImageDTO].self, forKey: .images).map { $0.1 }
    }
}
