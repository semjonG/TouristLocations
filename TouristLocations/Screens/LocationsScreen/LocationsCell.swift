//
//  LocationsCell.swift
//  TouristLocations
//
//  Created by mac on 12.05.2023.
//

import SwiftUI

struct LocationsCell: View {
  @ObservedObject var placeLocation: LocationsCellModel
  
  var body: some View {
    HStack {
      image
      VStack(alignment: .leading) {
        Text(placeLocation.name)
          .font(.headline)
        Text(placeLocation.description)
          .font(.subheadline)
        Spacer()
      }
      .padding(.all, 10.0)
      .frame(height: 100, alignment: .center)
    }
  }
  
  private var image: some View {
    Group {
      if let image = placeLocation.tourImage {
        Image(uiImage: image)
          .resizable()
          .clipped()
      } else {
        Rectangle()
          .fill(Color.gray)
          .onAppear { placeLocation.fetchImage() }
      }
    }
    .frame(width: 100, height: 80)
    .cornerRadius(10)
    .padding(.all, 10.0)
  }
}

