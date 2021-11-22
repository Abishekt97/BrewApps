//
//  BrewAppBaseVideoCollectionViewCell.swift
//  BrewApps
//
//  Created by Abishek on 22/11/21.
//

import UIKit

class BrewAppBaseVideoCollectionViewCell: UICollectionViewCell {
    
  lazy var imageView: UIImageView! = {
    
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleToFill
    return imageView
    
  }()
  
  lazy var deleteButton: UIButton! = {
    
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.contentMode = .scaleAspectFill
    button.setImage(UIImage(named: "Trash"), for: .normal)
    button.addTarget(self, action: #selector(self.trashClicked), for: .touchUpInside)
    return button
    
  }()

  
  lazy var playButton: UIButton! = {
    
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(.init(imageLiteralResourceName: "PayImage"), for: .normal)
    return button

  }()
  
  var preview: BrewAppMovieNowPlayingResult?
  var deleteView: ((IndexPath) -> ())?
  var indexPath: IndexPath? = nil
  
  deinit{
    
    self.preview = nil
    self.indexPath = nil
    self.deleteView = nil
    
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.addConstraintAndView()
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")

  }
  
}

extension BrewAppBaseVideoCollectionViewCell{
  
@objc func addConstraintAndView(){
    
    self.contentView.addSubview(self.deleteButton)
    
    NSLayoutConstraint.activate([
    
      self.deleteButton.topAnchor.constraint(equalTo: self.contentView.topAnchor),
      self.deleteButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
      self.deleteButton.widthAnchor.constraint(equalToConstant: 35),
      self.deleteButton.heightAnchor.constraint(equalToConstant: 35)
    
    ])
    
  }
  
}

extension BrewAppBaseVideoCollectionViewCell{
  
  @objc func trashClicked(){
    
    guard let indexPath = indexPath else { return  }
    
    self.deleteView?(indexPath)
    
  }
  
}
