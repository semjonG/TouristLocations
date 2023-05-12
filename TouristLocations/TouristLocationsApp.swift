//
//  TouristLocationsApp.swift
//  TouristLocations
//
//  Created by mac on 12.05.2023.
//

import SwiftUI

@main
struct TouristLocationsApp: App {
  var body: some Scene {
    WindowGroup {
      CategoryView()
        .preferredColorScheme(.dark)
    }
  }
}
