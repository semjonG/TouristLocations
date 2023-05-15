//
//  CategoryCell.swift
//  TouristLocations
//
//  Created by mac on 12.05.2023.
//

import SwiftUI

struct CategoryCell: View {
  @ObservedObject var category: CategoryCellModel
  var body: some View {
    HStack {
      Text(category.name)
      Spacer()
      ZStack {
        Circle()
          .foregroundColor(category.color.hexColor)
          .frame(width: 30, height: 30, alignment: .center)
        Text("\(category.count)")
      }
    }
  }
}

struct CategoryCell_Previews: PreviewProvider {
  static var previews: some View {
    CategoryCell(category: CategoryCellModel(category: Category(name: "Интересные места", type: .food, colour: .cyan10, count: 15)))
  }
}


