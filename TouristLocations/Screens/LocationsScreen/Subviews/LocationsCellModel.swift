//
//  LocationsCellModel.swift
//  TouristLocations
//
//  Created by mac on 12.05.2023.
//

import SwiftUI

final class LocationsCellModel: ObservableObject, Identifiable {
  
  let placeLocation: PlaceLocation
  @Published var placeImage: UIImage?
  
  var name: String { placeLocation.name }
  var description: String { placeLocation.description }
  var imageURL: URL { URL(string: placeLocation.image)! }
  var latitude: Double { placeLocation.lat }
  var longitude: Double { placeLocation.lon }
  var type: TypeEnum { placeLocation.type }

  static var defaultImage: UIImage {
    UIImage(named: "placeholder")!
  }
  
  init(place: PlaceLocation) {
    self.placeLocation = place
  }
  
  func fetchImage() {
    URLSession.shared.dataTaskPublisher(for: imageURL)
      .assumeHTTP()
      .responseData()
      .receive(on: DispatchQueue.main)
      .map { UIImage(data: $0) }
      .replaceError(with: Self.defaultImage)
      .assign(to: &$placeImage)
  }
}

