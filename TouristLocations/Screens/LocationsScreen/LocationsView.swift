//
//  LocationsView.swift
//  TouristLocations
//
//  Created by mac on 12.05.2023.
//

import SwiftUI

struct LocationsView: View {
  var viewModel: [LocationsCellModel] = []
  
  init(model: [LocationsCellModel]) {
    viewModel = model
  }
  
  var body: some View {
    List(viewModel) { place in
      LocationsCell(placeLocation: place)
        .onTapGesture { open2Gis(place.longitude, place.latitude) }
        .navigationTitle("Объекты")
    }
    .listStyle(.plain)
  }
  
  private func open2Gis(_ longitude: Double, _ latitude: Double) {
    let application = UIApplication.shared
    let appPath = "dgis://2gis.ru/routeSearch/rsType/car/to/\(longitude),\(latitude)"
    
    if let appURL = URL(string: appPath) {
      let appStoreURL = URL(string: "https://itunes.apple.com/ru/app/id481627348")!
      
      if application.canOpenURL(appURL) {
        application.open(appURL, options: [:], completionHandler: nil)
      } else {
        application.open(appStoreURL)
      }
    } else {
      print("Invalid URL")
    }
  }
}

