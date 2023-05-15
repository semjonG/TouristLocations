//
//  TouristLocationsApp.swift
//  TouristLocations
//
//  Created by mac on 12.05.2023.
//

import SwiftUI
import CoreLocation

@main
struct TouristLocationsApp: App {
  var body: some Scene {
    WindowGroup {
      CategoryView()
        .onAppear() {
          CLLocationManager().requestWhenInUseAuthorization()
        }
        .preferredColorScheme(.dark)
    }
  }
}
