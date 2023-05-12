//
//  LocationsCellModel.swift
//  TouristLocations
//
//  Created by mac on 12.05.2023.
//

import SwiftUI

final class LocationsCellModel: ObservableObject, Identifiable {
  
  let tour: Object
  @Published var tourImage: UIImage?
  
  var name: String { tour.name }
  var description: String { tour.description }
  var imageURL: URL { URL(string: tour.image)! }
  var latitude: Double { tour.lat }
  var longitude: Double { tour.lon }
  var type: TypeEnum { tour.type }

  static var defaultImage: UIImage {
    UIImage(named: "placeholder")!
  }
  
  init(tour: Object) {
    self.tour = tour
  }
  
  func fetchImage() {
    URLSession.shared.dataTaskPublisher(for: imageURL)
      .assumeHTTP()
      .responseData()
      .receive(on: DispatchQueue.main)
      .map { UIImage(data: $0) }
      .replaceError(with: Self.defaultImage)
      .assign(to: &$tourImage)
  }
}

