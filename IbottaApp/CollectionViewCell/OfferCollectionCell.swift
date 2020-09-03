//
//  OfferCollectionCell.swift
//  IbottaApp
//
//  Created by nikita lalwani on 8/24/20.
//  Copyright © 2020 nikita lalwani. All rights reserved.
//

import UIKit

protocol FavoriteProtocol {
    func buttonTapped(_ sender: UIButton)
}
class OfferCollectionCell: UICollectionViewCell {

     // MARK: Properties
    var imgItem: UIImageView?
    var txtPrice: UILabel?
    var txtName: UILabel?
    var btnFavorite: UIButton?
    var isfavorite: Bool = false
    var offer: Offer?
    var delegate: FavoriteProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        //setting up the view
        self.contentView.isUserInteractionEnabled = false
        let imageView = UIImageView.init(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //Sets the background grey color for Imageview
        imageView.backgroundColor = Utilities.Colors.cellBackground
        imageView.layer.cornerRadius = 5.0
        NSLayoutConstraint.activate([
          imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 6),
          imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 6),
          imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -6),
          imageView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.74)
        ])
        imgItem = imageView
        
        let priceLabel = UILabel.init(frame: .zero)
        self.contentView.addSubview(priceLabel)
        priceLabel.font = Utilities.font.amountFont
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
           priceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
           priceLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 6)
        ])
        txtPrice = priceLabel
        
        let favorite = UIButton.init(frame: .zero)
        self.contentView.addSubview(favorite)
        favorite.setFavoriteImageForItem((offer?.id) ?? "")
        favorite.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          favorite.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
          favorite.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
          favorite.heightAnchor.constraint(equalToConstant: 25),
          favorite.widthAnchor.constraint(equalToConstant: 25),
        ])
        favorite.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        btnFavorite = favorite

        let nameLabel = UILabel.init(frame: .zero)
        self.contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = Utilities.font.nameFont
        NSLayoutConstraint.activate([
          nameLabel.topAnchor.constraint(equalTo: (btnFavorite?.bottomAnchor)!, constant: 5),
          nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 6),
          nameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0)
        ])
        txtName = nameLabel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Delegate method to set favorite item. This method is handled by OfferController
    @objc func buttonTapped(_ sender: UIButton) {
        delegate?.buttonTapped(sender)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        var view = btnFavorite?.hitTest(btnFavorite?.convert(point, from: self) ?? CGPoint(x: 0, y: 0), with: event)
        if view == nil {
            view = super.hitTest(point, with: event)
        }

        return view
    }

}
