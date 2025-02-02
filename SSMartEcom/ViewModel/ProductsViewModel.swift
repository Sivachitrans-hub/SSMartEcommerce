//
//  ProductsViewModel.swift
//  SSMartEcom
//
//  Created by siva chitran p on 01/02/25.
//

import SwiftUI
import Combine

@MainActor
class ProductsViewModel : ObservableObject {
    
    @Published var products : [ProductsModel] = []
    private var cancellables = Set<AnyCancellable>()
    @Published var searchText =  ""
    @Published var filteredItems:[ProductsModel] = []
    @Published var showAlert : Bool = false
    @Published var showLoader:Bool = true
    var message : String = ""
    
    init() {
        // Observe searchText changes and update filteredItems
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main) // Avoid rapid updates
            .removeDuplicates()
            .sink { [weak self] searchText in
                self?.filterItems(with: searchText)
            }
            .store(in: &cancellables)
    }
    
    
    func getSSProductsData() async  {
        do  {
            products = try await NetworkManager.shared.fetchData(type:[ProductsModel].self , from: APIManager.productsURL)
            filterItems(with: "")
            showLoader = false
        }catch let error   {
            print(error)
            if let networkErr = error as? NetworkError {
                switch networkErr {
                case .invalidURL:
                    message = "Something went wrong, Please try again later"
                case .invalidResponse:
                    message = "Something went wrong, Please try again later"
                case .decodingError(let string):
                    message = string
                case .noInternet:
                    message = "The Internet connection appears to be offline."
                }
                showAlert.toggle()
            }
            showLoader = false
        }
    }
    

    
    private func filterItems(with query: String) {
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedQuery.isEmpty {
            filteredItems = products
        } else {
            filteredItems = products.filter { product in
                guard let title = product.title else { return false }
                return title.contains(query)
            }
        }
    }
    
}


