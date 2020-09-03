//
//  Offer.swift
//  IbottaApp
//
//  Created by nikita lalwani on 9/2/20.
//  Copyright © 2020 nikita lalwani. All rights reserved.
//

import UIKit

//This class maintains the offer model values along with their coding keys
class Offer: Codable {

     public var id: String?
     public var name: String?
     public var url: String?
     public var currentValue: String?
     public var terms: String?
     public var desc: String?
     public var isFavorite: Bool? = false

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case url
        case desc = "description"
        case terms
        case currentValue = "current_value"
    }
}
