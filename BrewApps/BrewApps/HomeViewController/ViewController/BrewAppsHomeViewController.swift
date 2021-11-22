//
//  BrewAppsHomeViewController.swift
//  BrewApps
//
//  Created by Abishek on 22/11/21.
//

import UIKit

class BrewAppsHomeViewController: UIViewController {
  
  lazy var searchBar: UISearchBar! = {
    
    let searchBarTextField = UISearchBar()
    searchBarTextField.translatesAutoresizingMaskIntoConstraints = false
    searchBarTextField.delegate = self
    return searchBarTextField
    
  }()
  
  lazy var collectionView: UICollectionView! = {
    
    let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout:  self.createBasicListLayout())
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.collectionViewLayout = self.createBasicListLayout()
    collectionView.register(BrewAppPopularVideoCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: BrewAppPopularVideoCollectionViewCell.self))
    collectionView.register(BrewAppUnPopularVideoCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: BrewAppUnPopularVideoCollectionViewCell.self))
    collectionView.backgroundColor = .white
    collectionView.delegate = self
    return collectionView
    
  }()
  
  lazy var modelController: BrewAppHomeController! = nil
  lazy var dataSource: BrewAppMovieNowPlayingDataSource? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = .white
    self.addConstraintAndView()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.modelController = BrewAppHomeController()
    self.setupCollectionView()
    self.apiCall()
    self.addDoneButtonOnKeyboard()
    
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.modelController = nil
  }
  
  func createBasicListLayout() -> UICollectionViewLayout {
    
    let fraction: CGFloat = 1 // 2
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .fractionalHeight(1))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(fraction))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    let section = NSCollectionLayoutSection(group: group)
    let configuration = UICollectionViewCompositionalLayoutConfiguration()
    configuration.scrollDirection = .vertical
    let layout = UICollectionViewCompositionalLayout(section: section, configuration: configuration)
    return layout
    
  }
  
}

extension BrewAppsHomeViewController {
  
  func addConstraintAndView(){
    
    self.view.addSubview(self.collectionView)
    self.view.addSubview(self.searchBar)

    NSLayoutConstraint.activate([
      
      self.collectionView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor),
      self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
      self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
      self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
      
      self.searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
      self.searchBar.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
      self.searchBar.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
      self.searchBar.heightAnchor.constraint(equalToConstant: 50)

      
    ])
    
  }
  
}

extension BrewAppsHomeViewController {

  func deleteTheData(index: IndexPath){
    
    guard let value = self.modelController.responseFilterModel?.results?[index.row] else{
      return 
    }
    guard var snapShot = dataSource?.snapshot() else{
      return
    }
    snapShot.deleteItems([value])
    dataSource?.apply(snapShot, animatingDifferences: true, completion: {
      DispatchQueue.main.async { [self] in
        snapShot.reloadItems(self.modelController.responseFilterModel?.results ?? [])
        self.dataSource?.apply(snapShot, animatingDifferences: true)
      }
    })
    self.modelController.responseFilterModel?.results?.remove(at: index.row)
    guard let firstIndex = self.modelController.responseModel?.results?.firstIndex(of: value) else{
      return
    }
    self.modelController.responseModel?.results?.remove(at: firstIndex)
        
  }
  
}

extension BrewAppsHomeViewController {
  
  func loadTheData(){
    
    var snapshot = NSDiffableDataSourceSnapshot<Int, BrewAppMovieNowPlayingResult>()
    snapshot.appendSections([0])
    snapshot.appendItems(self.modelController.responseFilterModel?.results ?? [])
    dataSource?.apply(snapshot, animatingDifferences: true)
    
  }
  
  func setupCollectionView(){
    self.dataSource = BrewAppMovieNowPlayingDataSource(collectionView: self.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
      var cell = BrewAppBaseVideoCollectionViewCell()
      if (itemIdentifier.voteAverage ?? 0) > 7{
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BrewAppPopularVideoCollectionViewCell.self), for: indexPath) as! BrewAppPopularVideoCollectionViewCell
      }else{
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BrewAppUnPopularVideoCollectionViewCell.self), for: indexPath) as! BrewAppUnPopularVideoCollectionViewCell
      }
      cell.preview = itemIdentifier
      cell.deleteView = { indexPath in
        DispatchQueue.main.async {
          self.deleteTheData(index: indexPath)
        }
      }
      cell.indexPath = indexPath
      return cell
    })
  }
  
  func apiCall(){
    self.modelController.apiError = { error in
      
    }
    self.modelController.apiSuccess = {
      DispatchQueue.main.async {
        self.loadTheData()
      }
    }
    self.modelController.callAPI()
  }
  
}

extension BrewAppsHomeViewController: UISearchBarDelegate, UITextFieldDelegate{
  
  func searchBar(_ searchBar: UISearchBar, textDidChange string: String){
    
    self.modelController.responseFilterModel?.results = []
    self.loadTheData()
    
    self.modelController.responseFilterModel?.results = self.modelController.responseModel?.results?.filter{$0.title?.lowercased().contains(string.lowercased()) ?? false}
    if string.isEmpty {
      self.modelController.responseFilterModel = self.modelController.responseModel
    }
    self.loadTheData()
  }
  
}

extension BrewAppsHomeViewController {
  
  func addDoneButtonOnKeyboard(){
    let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
    doneToolbar.barStyle = .default
    
    let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
    
    let items = [flexSpace, done]
    doneToolbar.items = items
    doneToolbar.sizeToFit()
    
    searchBar.inputAccessoryView = doneToolbar
  }
  
  @objc func doneButtonAction(){
    searchBar.resignFirstResponder()
  }
  
}

extension BrewAppsHomeViewController: UICollectionViewDelegate{
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    let detailVC = BrewAppDetailsViewController()
    detailVC.preview = self.modelController.responseFilterModel?.results?[indexPath.row]
    self.navigationController?.pushViewController(detailVC, animated: true)
    
  }
  
}
