    //
    //  Utilities.swift
    //  IbottaApp
    //
    //  Created by nikita lalwani on 9/1/20.
    //  Copyright © 2020 nikita lalwani. All rights reserved.
    //

    import UIKit

    class Utilities {

    static let dummyText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    
    //This method is to clear the user defaults
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }

    //Fonts used across the app
    struct font {
      static let amountFont = UIFont.init(name: "AvenirNext-DemiBold", size: 12)
      static let nameFont = UIFont.init(name: "AvenirNext-Regular", size: 11)
      static let smallFont = UIFont.init(name: "AvenirNext-Regular", size: 9)
      static let smallBoldFont = UIFont.init(name: "AvenirNext-Regular", size: 9)
      static let largeFont = UIFont.init(name: "AvenirNext-Regular", size: 12)
      static let largeBoldFont = UIFont.init(name: "AvenirNext-DemiBold", size: 12)
      static let XLFont = UIFont.init(name: "AvenirNext-Regular", size: 16)
      static let XLBoldFont = UIFont.init(name: "AvenirNext-DemiBold", size: 16)

    }
    
    //Colors used across the app
    struct Colors {
        static let cellBackground = UIColor.init(red: 241/255, green: 242/255, blue: 245/255, alpha: 1)
    }
 }

// MARK: - UIImageView
extension UIImageView{

    //This method converts the given URL as parameter to image
    func setImageFromURl(_ url: String) {
        guard let url = URL(string: url) else { return }
        //set placeholder image
        self.image = UIImage(named: "NoImage")
        //Downloading the images on background thread
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            
            if let data = data, let img = UIImage(data: data) {
                //updating the UI on main thread
                DispatchQueue.main.async {
                    self.image = img
                }
            }
        }
  }
}

extension UIButton {
    //This method sets the respective item's favorite button image based on whether it's marked favorite or not
    func setFavoriteImageForItem(_ id: String) {
        let value = UserDefaults.standard.bool(forKey:id)
        if value == true {
            self.setBackgroundImage(UIImage(named: "favorite"), for: .normal)
        } else {
            self.setBackgroundImage(UIImage(named: "favorite-white"), for: .normal)
        }
    }
}
