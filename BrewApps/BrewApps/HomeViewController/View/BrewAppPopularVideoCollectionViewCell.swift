//
//  BrewAppPopularVideoCollectionViewCell.swift
//  BrewApps
//
//  Created by Abishek on 22/11/21.
//

import UIKit

class BrewAppPopularVideoCollectionViewCell: BrewAppBaseVideoCollectionViewCell {

  override init(frame: CGRect) {
    super.init(frame: frame)
    
  }
  
  override var preview: BrewAppMovieNowPlayingResult?{
    
    didSet{
      guard let string = preview?.backDropImageURL(), let url = URL(string: string) else { return  }
      self.imageView.load(url: url)
    }
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

extension BrewAppPopularVideoCollectionViewCell{
  
  override func addConstraintAndView(){
    
    self.contentView.addSubview(self.imageView)
    self.contentView.addSubview(self.playButton)
    
    NSLayoutConstraint.activate([
    
      self.imageView.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor),
      self.imageView.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor),
      self.imageView.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor),
      self.imageView.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor),
      
      self.playButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
      self.playButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
      self.playButton.heightAnchor.constraint(equalToConstant: 60),
      self.playButton.widthAnchor.constraint(equalToConstant: 60),

    ])

    super.addConstraintAndView()
    
  }
  
}
