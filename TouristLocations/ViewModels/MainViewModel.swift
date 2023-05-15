//
//  MainViewModel.swift
//  TouristLocations
//
//  Created by mac on 12.05.2023.
//

import SwiftUI
import Combine

final class MainViewModel: ObservableObject {
  
  private let networkManager = NetworkManager()
  
  @Published var isLoading = false
  @Published var categories: [CategoryCellModel] = []
  @Published var locations: [LocationsCellModel] = []
  @Published var error: IdentifiableError<HTTPError>?
  
  struct IdentifiableError<E: Error>: Identifiable {
    let id = UUID()
    let identifiableError: E
  }
  
  init() {
    fetchData()
  }
  
  func fetchData() {
    error = nil
    let responseData = networkManager.sendRequest(decoding: RstTur.self)
      .handleEvents(
        receiveSubscription: { [unowned self] _ in
          isLoading = true
        },
        receiveCompletion: { [unowned self] _ in
          isLoading = false
        },
        receiveCancel: { [unowned self] in
          isLoading = false
        })
      .catch { [unowned self] error -> Just<RstTur> in
        self.error = IdentifiableError(identifiableError: error )
        return Just(
          RstTur(data: DataClass(
            geo: Coordinates(lat: 0.02, lon: 9.2),
            categories: [Category(name: "", type: .child, colour: .danger10, count: 4)],
            objects: [PlaceLocation(name: "", description: "", image: "", type: .child, lat: 0.3, lon: 0.4)])
          )
        )
      }
      .share()
    
    responseData
      .flatMap { $0.data.categories.publisher }
      .map { CategoryCellModel(category: $0) }
      .collect()
      .assign(to: &$categories)
    
    responseData
      .flatMap { $0.data.objects.publisher }
      .map { LocationsCellModel(place: $0) }
      .collect()
      .assign(to: &$locations)
  }
}
