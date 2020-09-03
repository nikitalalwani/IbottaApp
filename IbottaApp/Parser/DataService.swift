//
//  DataService.swift
//  IbottaApp
//
//  Created by nikita lalwani on 9/1/20.
//  Copyright © 2020 nikita lalwani. All rights reserved.
//

import UIKit

class DataService: NSObject {
    
    //This method loads all the data from json file and converts them into offer model format
    func loadOffers(completion: @escaping (_ offers: [Offer]?) -> ()){
        
        do {
        let url = Bundle.main.url(forResource: "Offers", withExtension: "json")

            // Parse JSON data
            let jsonData = try Data(contentsOf: url!)
            let decoder = JSONDecoder()
            let json = try decoder.decode([Offer].self, from: jsonData)
            completion(json)
        }
    catch {
            print(error)
        }

}
    
}
