//
//  ViewModel.swift
//  IbottaApp
//
//  Created by nikita lalwani on 8/24/20.
//  Copyright © 2020 nikita lalwani. All rights reserved.
//

import CoreData
import Reachability

protocol OfferViewModelProtocol {
    func viewOfferDetails(_ offer: Offer)
}

class ViewModel: NSObject {

    var parser = OffersParser()
    var offers: [Offer]?
    let reachability = try! Reachability()
    var delegate: OfferViewModelProtocol?

    func fetchOffers(completion: @escaping () -> ()) {
        
        if reachability.connection == .cellular || reachability.connection == .wifi {
            parser.loadOffers { (offerList) in
                self.offers = offerList
                completion()
            }
        } else if reachability.connection == .unavailable {
            let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

                var request = NSFetchRequest<NSFetchRequestResult>()
            request = Offer.fetchRequest()
                //request.predicate = NSPredicate(format: "age = %@", "12")
                request.returnsObjectsAsFaults = false
                do {
                    let result = try managedObjectContext.fetch(request)
                    self.offers = result as? [Offer]
                    completion()
                    
                } catch {
                    print("Failed")
                }
            }

    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        return offers?.count ?? 0
    }

    func configureCellData(_ cell: UICollectionReusableView, in collectionView: UICollectionView, at indexPath: IndexPath) {
        
        guard let cell = cell as? OfferCollectionCell else {return}
        guard let currentOffer = self.offers?[indexPath.row] else {return}
        cell.itemImage?.image = UIImage(named: "NoImage")
        if let url = currentOffer.url {
             self.loadImage(URL(string: url)!) { (img) in
                 DispatchQueue.main.async {
                    cell.itemImage?.image = img
                 }
             }
        }
        cell.itemPrice?.text = currentOffer.currentValue
        cell.desc?.text = currentOffer.desc
    }
    
    func loadImage(_ url: URL, closure: @escaping (UIImage?) -> ()) {
        DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                           closure(image)
                    }
                }
            }
        }
    
    func viewOffer(_ indexPath: Int) {
        delegate?.viewOfferDetails(self.offers?[indexPath] ?? Offer())
    }

    
}
