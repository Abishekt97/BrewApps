//
//  BrewAppMovieNowPlayingDate.swift
//  BrewApps
//
//  Created by Abishek on 22/11/21.
//

import Foundation

struct BrewAppMovieNowPlayingDate : Codable {
  
  let maximum : String?
  let minimum : String?
  
  enum CodingKeys: String, CodingKey {
    case maximum = "maximum"
    case minimum = "minimum"
  }
  
  init(from decoder: Decoder) throws {
    let values = try? decoder.container(keyedBy: CodingKeys.self)
    maximum = try? values?.decodeIfPresent(String.self, forKey: .maximum)
    minimum = try? values?.decodeIfPresent(String.self, forKey: .minimum)
  }
  
}
