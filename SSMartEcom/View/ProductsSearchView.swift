//
//  ProductsSearchView.swift
//  SSMartEcom
//
//  Created by siva chitran p on 01/02/25.
//

import SwiftUI

struct ProductsSearchView : View {
   
    @Binding  var searchText : String
    @Binding  var productItems : [ProductsModel]
    
    
//    var filteredProducts : [ProductsModel] {
//        if self.filteredProducts.isEmpty {
//            //return self.filteredProducts
//        }else {
//            //return filteredProducts.filter({$0.category?.contains(searchText.lowercased())})
//        }
//    }
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Search products", text: $searchText)
        }
        .padding(.horizontal)
        .frame(height: 50)
        .background(.appBgSecondary)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .padding(.horizontal)
        
        
        
    }
}
