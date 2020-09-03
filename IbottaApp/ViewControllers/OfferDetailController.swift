    //
    //  OfferDetailController.swift
    //  IbottaApp
    //
    //  Created by nikita lalwani on 8/26/20.
    //  Copyright © 2020 nikita lalwani. All rights reserved.
    //

    import UIKit

    class OfferDetailController: UIViewController, UIScrollViewDelegate {

    // MARK: Properties
    var imgItem: UIImageView?
    var lblPrice: UILabel?
    var lblDesc: UILabel?
    var lblName: UILabel?
    var lblTerms: UILabel?
    var lblDetails: UILabel?
    var btnFavorite: UIButton?
    var offerDetails: Offer?
    
    
    let detailString = "Details"
    let titleString = "Offer Detail"
    let ingredientsString = "INGREDIENTS"

    let scrollView = UIScrollView()
    let contentView = UIView.init(frame: .zero)

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = titleString
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.scrollView)
        self.scrollView.delegate = self
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false;
        self.scrollView.isScrollEnabled = true
        //Constrain scroll view
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        //Add and setup content view for scroll content
        self.scrollView.addSubview(self.contentView)
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        ])
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        setupView()
    }

    override func viewWillLayoutSubviews() {
      self.scrollView.contentSize = CGSize(width: self.contentView.bounds.width, height: self.contentView.bounds.height + 100)

    }
        
    func setupView() {
        
        //User interface along with autolayout
        let favorite = UIButton.init(frame: .zero)
        self.contentView.addSubview(favorite)
        
        //setting up the favorite button based on user defaults value
        favorite.setFavoriteImageForItem(offerDetails?.id ?? "")
        favorite.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favorite.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
          favorite.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
          favorite.heightAnchor.constraint(equalToConstant: 25),
          favorite.widthAnchor.constraint(equalToConstant: 25)
        ])
        favorite.addTarget(self, action: #selector(favoriteButtonTapped(_:)), for: .touchUpInside)
        btnFavorite = favorite
        
        let nameLabel = UILabel.init(frame: .zero)
        self.contentView.addSubview(nameLabel)
        nameLabel.text = offerDetails?.name
        nameLabel.textColor = UIColor.black
        nameLabel.font = Utilities.font.XLBoldFont
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: (btnFavorite?.bottomAnchor)!, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
            nameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0)
           ])
        lblName = nameLabel

        let imageView = UIImageView.init(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        self.contentView.addSubview(imageView)
        imageView.setImageFromURl(offerDetails?.url ?? "")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: (lblName?.bottomAnchor)!, constant: 10),
          imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 6),
          imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0),
          imageView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.5)
        ])
        imgItem = imageView

        let priceLabel = UILabel.init(frame: .zero)
        self.contentView.addSubview(priceLabel)
        priceLabel.text = offerDetails?.currentValue
        priceLabel.textAlignment = .center
        priceLabel.textColor = UIColor.black
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.font = Utilities.font.XLBoldFont
         NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: (imgItem?.bottomAnchor)!, constant: 10),
            priceLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
            priceLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0)

         ])
         lblPrice = priceLabel

        let details = UILabel(frame: .zero)
        self.contentView.addSubview(details)
        details.text = detailString
        details.numberOfLines = 1
        details.textAlignment = .center
        details.textColor = UIColor.black
        details.font = Utilities.font.XLBoldFont
        details.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
           details.topAnchor.constraint(equalTo: (lblPrice?.bottomAnchor)!, constant: 30),
           details.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5),
           details.centerXAnchor.constraint(equalToSystemSpacingAfter: self.contentView.centerXAnchor, multiplier: 0),
           details.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0)
        ])

        let lineview = UILabel(frame: .zero)
        self.contentView.addSubview(lineview)
        lineview.backgroundColor = UIColor.systemPink
        lineview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineview.topAnchor.constraint(equalTo: details.bottomAnchor, constant: 0),
            lineview.heightAnchor.constraint(equalToConstant: 1),
            lineview.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
            lineview.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0)
        ])

        let descLabel = UILabel.init(frame: .zero)
        self.contentView.addSubview(descLabel)
        descLabel.text = offerDetails?.desc
        descLabel.textColor = UIColor.black
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.font = Utilities.font.amountFont
        NSLayoutConstraint.activate([
            descLabel.topAnchor.constraint(equalTo: lineview.bottomAnchor, constant: 10),
            descLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            descLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0)
        ])
        lblDesc = descLabel
        
        //Dummy text for design
        let ingredients = UILabel.init(frame: .zero)
        self.contentView.addSubview(ingredients)
        ingredients.text = ingredientsString
        ingredients.textColor = UIColor.black
        ingredients.translatesAutoresizingMaskIntoConstraints = false
        ingredients.font = Utilities.font.XLBoldFont
        NSLayoutConstraint.activate([
            ingredients.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 10),
            ingredients.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            ingredients.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0)
        ])
        
        let ingredientsLabel = UILabel.init(frame: .zero)
        self.contentView.addSubview(ingredientsLabel)
        ingredientsLabel.text = Utilities.dummyText
        ingredientsLabel.textColor = UIColor.black
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        ingredientsLabel.font = Utilities.font.largeFont
        ingredientsLabel.lineBreakMode = .byWordWrapping
        ingredientsLabel.numberOfLines = 5
        NSLayoutConstraint.activate([
            ingredientsLabel.topAnchor.constraint(equalTo: ingredients.bottomAnchor, constant: 0),
            ingredientsLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            ingredientsLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0)
        ])

        let termsLabel = UILabel.init(frame: .zero)
        self.contentView.addSubview(termsLabel)
        termsLabel.text = offerDetails?.terms
        termsLabel.numberOfLines = 0
        termsLabel.textColor = UIColor.black
        termsLabel.translatesAutoresizingMaskIntoConstraints = false
        termsLabel.font = Utilities.font.smallFont
        NSLayoutConstraint.activate([
            termsLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            termsLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0),
            termsLabel.topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: ingredientsLabel.bottomAnchor, multiplier: 10),
            termsLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
        ])
        lblTerms = termsLabel
    }
        //Favorite button tapped action
        @objc func favoriteButtonTapped(_ sender: UIButton) {
            
            let userDefaults = UserDefaults.standard
            if !sender.isSelected {
                userDefaults.set(true, forKey: (offerDetails?.id)!)
                userDefaults.synchronize()
                sender.setFavoriteImageForItem((offerDetails?.id)!)
                sender.isSelected = true
            } else {
                userDefaults.set(false, forKey: (offerDetails?.id)!)
                userDefaults.synchronize()
                sender.setFavoriteImageForItem((offerDetails?.id)!)
                sender.isSelected = false
            }
        }
    }
