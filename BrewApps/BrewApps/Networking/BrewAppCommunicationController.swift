//
//  BrewAppCommunicationController.swift
//  BrewApps
//
//  Created by Abishek on 22/11/21.
//

import Foundation

struct BrewAppCommunicationController {
  
  static let queue = DispatchQueue(label: Bundle.main.bundleIdentifier ?? "queue.app.brewapp.main", qos: .background, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .global(qos: .userInitiated))
  
  public static let operationQueue: OperationQueue = {
    let operation = OperationQueue()
    operation.qualityOfService = .background
    operation.maxConcurrentOperationCount = 1
    operation.name = Bundle.main.bundleIdentifier
    return operation
  }()
  
  public static let customSession: URLSession = {
    let configuration = URLSessionConfiguration.ephemeral
    configuration.timeoutIntervalForRequest = 120
    let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: operationQueue)
    return session
  }()
  
  
  static func networkRequest(endPoint: URLHandler, requestMethod:HTTPMethod = .get , params: [String: String]? = nil, postBody: [String: Any]? = nil, completionHandler: @escaping (Data?, String?, BrewAppHTTPStatusCode?) -> ()) {
    guard Reachability.isConnectedToNetwork() else {
      completionHandler(nil, "No internet", nil)
      return
    }
    
    let urlComponend = BrewAppCommunicationController.urlComponentsHandler(params: params, endPoint: endPoint.endPoint)
    
    guard let url = urlComponend?.url else {
      return
    }
    
    debugPrint("------------------------->url", url)
    debugPrint("------------------------->postBody", postBody ?? [:])
    
    var request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 120)
    request.httpMethod = requestMethod.rawValue
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    if let body = postBody, let data = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted){
      request.httpBody = data
    }
    self.apiCall(request: request) { data, error, statusCode in
      completionHandler(data, error, statusCode)
    }
  }
  
  static func apiCall(request: URLRequest, completionHandler: @escaping (Data?, String?, BrewAppHTTPStatusCode?) -> ()){
    queue.async {
      self.customSession.dataTask(with: request) { (data, response, error) in
        
        guard let response = response as? HTTPURLResponse else {
          completionHandler(nil, "Something wents wroung", nil)
          return
        }
        guard let data = data else{
          completionHandler(nil, nil, response.status)
          return
        }
        completionHandler(data, nil, response.status)
        
      }.resume()
    }
  }
  
  static func urlComponentsHandler(params: [String: String]?, endPoint: String) -> URLComponents? {
    var urlComponend = URLComponents(string: endPoint)
    
    if let urlParams = params{
      var item = [URLQueryItem]()
      for (_, (key, value)) in urlParams.enumerated(){
        item.append(URLQueryItem(name: key, value: value))
      }
      urlComponend?.queryItems = item
    }
    return urlComponend
  }
  
  
}


enum URLHandler{
  
  static private let infoDic = Bundle.main.infoDictionary
  
  static private let baseURL = infoDic?["Base_URL"] as? String ?? ""
  static let imageBaseURL = infoDic?["Base_Image_URL"] as? String ?? ""
  static let backDropImaheURL = infoDic?["BackDrop_Image"] as? String ?? ""
  static private let apiKey = infoDic?["API_Key"] as? String ?? ""

  case now_playing
  case videos(id: String)

  var endPoint:String{
    
      return  URLHandler.baseURL + rawValue
    
  }
  
  var rawValue: String{
    switch self{
      
    case .now_playing:
      return "now_playing?api_key=\(URLHandler.apiKey)"
    case .videos(id: let id):
      return "\(id)/videos?api_key=\(URLHandler.apiKey)"
    }
  }
  
}

enum HTTPMethod: String {
  
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case delete = "DELETE"

}
