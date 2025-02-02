//
//  ProductsViewModel.swift
//  SSMartEcom
//
//  Created by siva chitran p on 01/02/25.
//

import Foundation
import SwiftUI

class ProductsViewModel : ObservableObject {
    
    @Published var products : [ProductsModel] = []
    @Published var showAlert : Bool = false
    var message : String = ""
    
    func getSSProductsData() async  {
        
        do  {
            
            products = try await NetworkManager.shared.fetchData(type:[ProductsModel].self , from: APIManager.productsURL)
            
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
                }
                showAlert.toggle()
            }
        }
    }
}
