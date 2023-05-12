//
//  NetworkManager.swift
//  TouristLocations
//
//  Created by mac on 12.05.2023.
//

import Foundation
import Combine

final class NetworkManager {
  
  static var jsonDecoder = JSONDecoder()
  let urlString = "https://rsttur.ru/api/base-app/map?id=117"
  
  init() {}
  
  func fetch<Model: Decodable>(decoding: Model.Type) -> AnyPublisher<Model, HTTPError> {
    guard let url = URL(string: urlString) else {
      fatalError("Invalid URL")
    }
    return URLSession.shared.dataTaskPublisher(for: url)
      .assumeHTTP()
      .responseData()
      .decoding(type: Model.self, decoder: Self.jsonDecoder)
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
}
