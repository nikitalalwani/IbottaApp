//
//  OffersController.swift
//  IbottaApp
//
//  Created by nikita lalwani on 8/24/20.
//  Copyright © 2020 nikita lalwani. All rights reserved.
//

import UIKit

class OffersController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, FavoriteProtocol {
    
     // MARK: Properties
    var collectionView: UICollectionView!
    var service = DataService()
    var offers: [Offer]?
    var isfavorite = false

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //setting up the collection view flow layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        layout.scrollDirection = .vertical

        layout.minimumLineSpacing = 24.0
        layout.minimumInteritemSpacing = 8.0
        layout.sectionInset = UIEdgeInsets(top: 20, left: 6, bottom: 0, right: 0)
        
        //setting the item size based on the ratios given in the mockup
        layout.itemSize = CGSize(width:0.45 * collectionView.bounds.width + 10, height: 0.22 * collectionView.bounds.height + 30)
        self.view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        collectionView.dataSource = self
        collectionView.delegate = self
        //Registering collection view cell with a unique identifier
        collectionView.register(OfferCollectionCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = UIColor.white
               

        //Loading all the offers when view is loaded for the first time
        service.loadOffers { (offerList) in
            self.offers = offerList
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        //Resetting the user defaults on every launch
        Utilities().resetDefaults()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.collectionView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Set frames of views that may have change
        collectionView.frame = view.frame
    }
    
    public override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {

        // Have the collection view re-layout its cells.
          coordinator.animate(
              alongsideTransition: { _ in self.collectionView.collectionViewLayout.invalidateLayout() },
              completion: { _ in }
          )
    }

    //MARK: Collection View Methods
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          CGSize(width:0.45 * collectionView.bounds.width + 10, height: 0.22 * collectionView.bounds.height + 30)
      }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.offers?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as? OfferCollectionCell
        //Sets this class as a delegate for protocol required to mark favorites
        cell?.delegate = self
        
        let currentOffer = self.offers?[indexPath.row]
        
        //Utility method
        cell?.imgItem?.setImageFromURl(currentOffer?.url ?? "")
        cell?.txtPrice?.text = currentOffer?.currentValue
        cell?.txtName?.text = currentOffer?.name
        cell?.btnFavorite?.tag = indexPath.row
        cell?.btnFavorite?.setFavoriteImageForItem((currentOffer?.id)!)
        
        return cell ?? UICollectionViewCell.init()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let vc = OfferDetailController()
        vc.offerDetails = offers?[indexPath.row]
        vc.btnFavorite?.tag = indexPath.row
        if let navigationController = self.navigationController {
          navigationController.pushViewController(vc, animated: true)
        }
    }
    
    //This method sets the favorite value in user defaults where key is the item id and value is either true or false
    //As an alternative to this method, we can also use core data but it's better to use User defaults to store such small values
    @objc func buttonTapped(_ sender: UIButton) {
        
        let userDefaults = UserDefaults.standard
        if !sender.isSelected {
            sender.setBackgroundImage(UIImage(named: "favorite"), for: .normal)
            userDefaults.set(true, forKey: self.offers?[sender.tag].id ?? "")
            sender.isSelected = true
        } else {
            sender.setBackgroundImage(UIImage(named: "favorite-white"), for: .normal)
            userDefaults.set(false, forKey: self.offers?[sender.tag].id ?? "")
            sender.isSelected = false
        }
    }
}
