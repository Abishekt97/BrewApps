//
//  BrewAppMovieNowPlayingDataSource.swift
//  BrewApps
//
//  Created by Anil Kumar on 22/11/21.
//

import UIKit

class BrewAppMovieNowPlayingDataSource: UICollectionViewDiffableDataSource<Int, BrewAppMovieNowPlayingResult>{
  
  override init(collectionView: UICollectionView, cellProvider: @escaping UICollectionViewDiffableDataSource<Int, BrewAppMovieNowPlayingResult>.CellProvider) {
    super.init(collectionView: collectionView, cellProvider: cellProvider)
  }
  
}
