//
//  OffersParser.swift
//  IbottaApp
//
//  Created by nikita lalwani on 8/24/20.
//  Copyright © 2020 nikita lalwani. All rights reserved.
//

import UIKit
import Foundation
import CoreData


class OffersParser: NSObject {


    func loadOffers(completion: @escaping (_ offers: [Offer]?) -> ()){
        
        let url = Bundle.main.url(forResource: "Offers", withExtension: "json")
        
//    do {
//            let data = try Data(contentsOf: url!)
//            let json = try JSONDecoder().decode([Offer].self, from: data)
//            completion(json)
//        }
        
        do {
            guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.context else {
                fatalError("Failed to retrieve context")
            }


            // Parse JSON data
            let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let jsonData = try Data(contentsOf: url!)
            let decoder = JSONDecoder()
            decoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext
            let json = try decoder.decode([Offer].self, from: jsonData)
            try managedObjectContext.save()
            completion(json)
        }
    
    catch {
            print(error)
        }
        
    }
}
