//
//  BrewAppUnPopularVideoCollectionViewCell.swift
//  BrewApps
//
//  Created by Abishek on 22/11/21.
//

import UIKit

class BrewAppUnPopularVideoCollectionViewCell: BrewAppBaseVideoCollectionViewCell {

  lazy var labelTitle: UILabel! = {
    
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .boldSystemFont(ofSize: 15)
    label.numberOfLines = 0
    label.textColor = .black
    return label
    
  }()
  
  lazy var labelDescription: UILabel! = {
    
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 12)
    label.numberOfLines = 0
    label.textColor = .gray
    return label
    
  }()
  
  lazy var view: UIView! = {
    
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
    
  }()

  override var preview: BrewAppMovieNowPlayingResult?{
    didSet{

      guard let string = preview?.posterImageURL(), let url = URL(string: string) else { return  }
      self.imageView.load(url: url)
      self.labelTitle.text = preview?.title
      self.labelDescription.text = preview?.overview

    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

extension BrewAppUnPopularVideoCollectionViewCell{
  
 override func addConstraintAndView(){
       
    self.contentView.addSubview(self.imageView)
    self.contentView.addSubview(self.playButton)
    self.contentView.addSubview(self.view)
    self.view.addSubview(self.labelTitle)
    self.view.addSubview(self.labelDescription)

    NSLayoutConstraint.activate([
    
      self.imageView.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor),
      self.imageView.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor),
      self.imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2),
      self.imageView.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor),
      
      self.playButton.centerXAnchor.constraint(equalTo: self.imageView.centerXAnchor),
      self.playButton.centerYAnchor.constraint(equalTo: self.imageView.centerYAnchor),
      self.playButton.heightAnchor.constraint(equalToConstant: 60),
      self.playButton.widthAnchor.constraint(equalToConstant: 60),
      
      self.view.centerYAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.centerYAnchor),
      self.view.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor),
      self.view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2),
      
      self.labelTitle.topAnchor.constraint(equalTo: self.view.topAnchor),
      self.labelTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
      self.labelTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),

      self.labelDescription.topAnchor.constraint(equalTo: self.labelTitle.bottomAnchor),
      self.labelDescription.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
      self.labelDescription.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
      self.labelDescription.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),

    ])

   super.addConstraintAndView()

  }
  
}
