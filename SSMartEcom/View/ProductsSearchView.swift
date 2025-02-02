//
//  ProductsSearchView.swift
//  SSMartEcom
//
//  Created by siva chitran p on 01/02/25.
//

import SwiftUI

struct ProductsSearchView : View {
   
    @Binding  var searchText : String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Search products", text: $searchText)
                .font(.poppins(.medium, size: 15))
        }
        .padding(.horizontal)
        .frame(height: 50)
        .background(.appBgSecondary)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .padding(.horizontal)
        
        
        
    }
}
