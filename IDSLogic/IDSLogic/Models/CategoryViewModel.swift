//
//  CategoryViewModel.swift
//  IDSLogic
//
//  Created by Rajshree Jaiswal on 09/10/24.
//

import Foundation

class CategoryViewModel: ObservableObject {
    @Published var categories: [FeedResult] = []
    
    init() {
        loadCategories()
    }
    
    private func loadCategories() {
        if let url = Bundle.main.url(forResource: "Data", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                
                let decodedResponse = try JSONDecoder().decode(Root.self, from: data)
                DispatchQueue.main.async {
                    self.categories = decodedResponse.data?.contentFeed?.feedResults ?? []
                }
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }
    }
}


struct Category: Identifiable, Codable {
    var id = String()
    let title: String
    let products: [Product]
}

struct Product: Identifiable, Codable {
    var id = String()
    let name: String
}
