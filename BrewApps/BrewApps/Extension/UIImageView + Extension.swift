//
//  UIImageView + Extension.swift
//  BrewApps
//
//  Created by Anil Kumar on 22/11/21.
//

import UIKit

var imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
  func load(url: URL) {
    if let image = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage{
      self.image = image
    }else{
      DispatchQueue.global().async { [weak self] in
        if let data = try? Data(contentsOf: url) {
          if let image = UIImage(data: data) {
            DispatchQueue.main.async {
              imageCache.setObject(image, forKey: url.absoluteString as NSString)
              self?.image = image
            }
          }
        }
      }
    }
  }
}
