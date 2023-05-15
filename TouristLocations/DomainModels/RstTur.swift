//
//  RstTur.swift
//  TouristLocations
//
//  Created by mac on 12.05.2023.
//

import SwiftUI

struct RstTur: Codable {
  let data: DataClass
  
  enum CodingKeys: String, CodingKey {
    case data = "data"
  }
}

struct DataClass: Codable {
  let geo: Coordinates
  let categories: [Category]
  let objects: [PlaceLocation]
}

struct Category: Codable {
  let name: String
  let type: TypeEnum
  let colour: Colour
  let count: Int
  
  enum CodingKeys: String, CodingKey {
    case colour = "color"
    case type = "type"
    case name = "name"
    case count = "count"
  }
}

struct Coordinates: Codable {
  let lat: Double
  let lon: Double
}

struct PlaceLocation: Codable {
  let name: String
  let description: String
  let image: String
  let type: TypeEnum
  let lat: Double
  let lon: Double
}

enum TypeEnum: String, Codable {
  case child
  case food
  case fun
  case gift
  case infrastructure
  case place
  case shop
}

enum Colour: String, Codable {
  case cyan10     = "cyan-10"
  case danger10   = "danger-10"
  case info10     = "info-10"
  case primary10  = "primary-10"
  case success10  = "success-10"
  case violet10   = "violet-10"
  case warning10  = "warning-10"
  
  var hexColor: Color {
    switch self {
    case .cyan10:    return Color(hex: "#00919B")
    case .danger10:  return Color(hex: "FF3D33")
    case .info10:    return Color(hex: "008BCC")
    case .primary10: return Color(hex: "1A81FA")
    case .success10: return Color(hex: "11A768")
    case .violet10:  return Color(hex: "#452799")
    case .warning10: return Color(hex: "EB8C00")
    }
  }
}

