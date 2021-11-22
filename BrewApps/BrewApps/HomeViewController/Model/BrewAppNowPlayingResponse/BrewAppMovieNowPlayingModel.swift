//
//  BrewAppMovieNowPlayingModel.swift
//  BrewApps
//
//  Created by Abishek on 22/11/21.
//


import Foundation

struct BrewAppMovieNowPlayingModel : Codable {
  
  let dates : BrewAppMovieNowPlayingDate?
  let page : Int?
  var results : [BrewAppMovieNowPlayingResult]?
  let totalPages : Int?
  let totalResults : Int?
  
  enum CodingKeys: String, CodingKey {
    case dates = "dates"
    case page = "page"
    case results = "results"
    case totalPages = "total_pages"
    case totalResults = "total_results"
  }
  
  init(from decoder: Decoder) throws {
    let values = try? decoder.container(keyedBy: CodingKeys.self)
    dates = try? values?.decodeIfPresent(BrewAppMovieNowPlayingDate.self, forKey: .dates)
    page = try? values?.decodeIfPresent(Int.self, forKey: .page)
    results = try? values?.decodeIfPresent([BrewAppMovieNowPlayingResult].self, forKey: .results)
    totalPages = try? values?.decodeIfPresent(Int.self, forKey: .totalPages)
    totalResults = try? values?.decodeIfPresent(Int.self, forKey: .totalResults)
  }
  
}
