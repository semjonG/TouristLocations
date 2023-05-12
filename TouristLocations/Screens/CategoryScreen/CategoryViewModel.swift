//
//  CategoryViewModel.swift
//  TouristLocations
//
//  Created by mac on 12.05.2023.
//

import SwiftUI
import Combine

final class CategoryViewModel: ObservableObject {
  
  private let networkManager = NetworkManager()
  
  @Published var isLoading = false
  @Published var categories: [CategoryCellModel] = []
  @Published var tours: [LocationsCellModel] = []
  @Published var error: IdentifiableError<HTTPError>?
  
  struct IdentifiableError<E: Error>: Identifiable {
    let id = UUID()
    let error: E
  }
  
  init() {
    fetch()
  }
  
  func fetch() {
    error = nil
    let responseData = networkManager.fetch(decoding: RstTur.self)
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
        self.error = IdentifiableError(error: error )
        return Just(
          RstTur(data: DataClass(
            geo: Coordinates(lat: 0.02, lon: 9.2),
            categories: [Category(name: "", type: .child, colour: .danger10, count: 4)],
            objects: [Object(name: "", description: "", image: "", type: .child, lat: 0.3, lon: 0.4)])
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
      .map { LocationsCellModel(tour: $0) }
      .collect()
      .assign(to: &$tours)
  }
}
