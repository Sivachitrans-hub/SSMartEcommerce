//
//  ProductsHeaderView.swift
//  SSMartEcom
//
//  Created by siva chitran p on 01/02/25.
//

import SwiftUI

struct ProductsHeaderView : View {
    var body: some View {
        Text("Saravana Store Products")
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding()
            .font(.poppins(.bold, size: 25))
            .foregroundStyle(.appTextPrimary)
    }
}
