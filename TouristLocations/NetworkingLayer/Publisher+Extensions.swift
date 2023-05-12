//
//  Publisher+Extensions.swift
//  TouristLocations
//
//  Created by mac on 12.05.2023.
//

import Combine
import Foundation

extension Publisher where Output == (data: Data, response: URLResponse) {
  func assumeHTTP() -> AnyPublisher<(data: Data, response: HTTPURLResponse), HTTPError> {
    tryMap { (data: Data, response: URLResponse) in
      guard let http = response as? HTTPURLResponse else { throw HTTPError.nonHTTPResponse }
      return (data, http)
    }
    .mapError { error in
      if error is HTTPError {
        return error as! HTTPError
      } else {
        return HTTPError.networkError(error)
      }
    }
    .eraseToAnyPublisher()
  }
}

extension Publisher where Output == (data: Data, response: HTTPURLResponse), Failure == HTTPError {
  func responseData() -> AnyPublisher<Data, HTTPError> {
    tryMap { (data: Data, response: HTTPURLResponse) -> Data in
      switch response.statusCode {
      case 200: return data
      case 400...499:
        throw HTTPError.requestFailed(response.statusCode)
      case 500...599:
        throw HTTPError.serverError(response.statusCode)
      default:
        fatalError("Unhandled HTTP Response Status code: \(response.statusCode)")
      }
    }
    .mapError { $0 as! HTTPError }
    .eraseToAnyPublisher()
  }
}

extension Publisher where Output == Data, Failure == HTTPError {
  func decoding<Item, Coder>(type: Item.Type, decoder: Coder) -> AnyPublisher<Item, HTTPError>
  where Item: Decodable,
        Coder: TopLevelDecoder,
        Self.Output == Coder.Input {
          decode(type: Item.self, decoder: decoder)
            .mapError {
              if $0 is HTTPError {
                return $0 as! HTTPError
              } else {
                let decodingError = $0 as! DecodingError
                return HTTPError.decodingError(decodingError)
              }
            }
            .eraseToAnyPublisher()
        }
}

