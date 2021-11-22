//
//  BrewAppHomeController.swift
//  BrewApps
//
//  Created by Abishek on 22/11/21.
//

import UIKit

class BrewAppHomeController: NSObject {
  
  internal var apiError:((String?) -> ())? = nil
  internal var apiSuccess:(() -> ())? = nil
  
  var responseModel: BrewAppMovieNowPlayingModel? = nil
  var responseFilterModel: BrewAppMovieNowPlayingModel? = nil

  deinit {
    self.apiError = nil
    self.apiSuccess = nil
    self.responseModel = nil
  }

  func callAPI() {
    
    BrewAppCommunicationController.networkRequest(endPoint: .now_playing) { data, error, statusCode in
      
      guard error == nil else{
        self.apiError?(error)
        return
      }
      
      guard let data = data else {
        self.apiError?("Unable to decode data")
        return
      }
      
      do{
        
        let response = try JSONDecoder().decode(BrewAppMovieNowPlayingModel.self, from: data)
        self.responseModel = response
        self.responseFilterModel = response
        self.apiSuccess?()
        
      } catch (let error){
        self.apiError?(error.localizedDescription)
      }
      
    }
    
  }
  
}
