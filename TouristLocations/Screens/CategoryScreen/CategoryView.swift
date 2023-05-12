//
//  CategoryView.swift
//  TouristLocations
//
//  Created by mac on 12.05.2023.
//

import SwiftUI

struct CategoryView: View {
  @ObservedObject var viewModel = CategoryViewModel()
  
  var body: some View {
    NavigationView {
      Group {
        if viewModel.isLoading {
          ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
        } else {
          categories
        }
      }
      .alert(item: $viewModel.error, content: { e -> Alert in
        Alert(
          title: Text("Unable to load Data"),
          message: Text(e.error.description),
          primaryButton: .default(Text("Retry"), action: {
            self.viewModel.fetch()
          }),
          secondaryButton: .cancel()
        )
      })
      .listStyle(.plain)
      .navigationTitle("Категории")
    }
  }
  
  private var categories: some View {
    List(viewModel.categories) { category in
      NavigationLink(
        destination: LocationsView(model: viewModel.tours.filter { $0.type == category.type }),
        label: {
          CategoryCell(category: category)
        })
    }
  }
}

