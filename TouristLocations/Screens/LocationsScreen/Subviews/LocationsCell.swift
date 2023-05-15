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
          .fixedSize(horizontal: false, vertical: true)
          .lineLimit(2)
        Text(placeLocation.description)
          .font(.subheadline)
          .lineLimit(2)
        Spacer()
      }
      .padding(.all, 8)
      .frame(height: 86, alignment: .center)
    }
  }
  
  private var image: some View {
    Group {
      if let image = placeLocation.placeImage {
        Image(uiImage: image)
          .resizable()
          .clipped()
      } else {
        Rectangle()
          .fill(Color.gray)
          .onAppear { placeLocation.fetchImage() }
      }
    }
    .frame(width: 86, height: 62)
    .cornerRadius(8)
    .scaledToFit()
  }
}

