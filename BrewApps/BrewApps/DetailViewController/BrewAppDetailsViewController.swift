//
//  BrewAppDetailsViewController.swift
//  BrewApps
//
//  Created by Anil Kumar on 22/11/21.
//

import UIKit

class BrewAppDetailsViewController: UIViewController {
  
   var preview: BrewAppMovieNowPlayingResult?
  
  lazy var imageView: UIImageView! = {
    
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    return imageView
    
  }()
  
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


  override func loadView(){
    super.loadView()
    
    //
    self.view.backgroundColor = .white`
    
    self.addConstraintAndView()
    self.addValue()
    
  }
  
}


extension BrewAppDetailsViewController{
  
  func addConstraintAndView(){
    
    self.view.addSubview(self.imageView)
    self.view.addSubview(self.labelTitle)
    self.view.addSubview(self.labelDescription)

    NSLayoutConstraint.activate([
    
      self.imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
      self.imageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
      self.imageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
      self.imageView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),

      self.labelTitle.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 20),
      self.labelTitle.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
      self.labelTitle.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
      
      self.labelDescription.topAnchor.constraint(equalTo: self.labelTitle.bottomAnchor, constant: 20),
      self.labelDescription.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
      self.labelDescription.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),

    ])
  }
  
  func addValue(){
    
    guard let string = preview?.backDropImageURL(), let url = URL(string: string) else { return  }
    self.imageView.load(url: url)
    self.labelTitle.text = preview?.title
    self.labelDescription.text = preview?.overview

  }
  
}
