//
//  User.swift
//  MyFavoriteApp
//
//  Created by Carson Buckley on 3/20/19.
//  Copyright © 2019 Launch. All rights reserved.
//

import Foundation

struct User: Codable {
    
    let name: String
    let favoriteApp: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case favoriteApp = "favApp"
        
    }
}
