//
//  ProductsGridView.swift
//  SSMartEcom
//
//  Created by siva chitran p on 02/02/25.
//

import SwiftUI

struct ProductsGridView : View {
    
    @Binding var products : [ProductsModel]
    
    
    var makeAPicall:(()->())
    
    let columns = [
        GridItem(.flexible(minimum: 70)),
        GridItem(.flexible(minimum: 70))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(products, id: \.id) { item in
                    SSMartEcomGridViewCell(product: item)
                }
            }
            .padding()
        }
        .refreshable {
            makeAPicall()
        }
    }
}
