//
//  ProductsHomeView.swift
//  SSMartEcom
//
//  Created by siva chitran p on 01/02/25.
//


import SwiftUI


struct ProductsHomeView: View {

    @ObservedObject var productsVM = ProductsViewModel()
    
    var body: some View {
        ZStack {
            Color(.appBgPrimary)
                .ignoresSafeArea()
            VStack {
                ProductsHeaderView()
                ProductsSearchView(searchText: $productsVM.searchText)
                if productsVM.filteredItems.isEmpty {
                    VStack(spacing:15) {
                       
                        if productsVM.showLoader {
                            ProgressView()
                        }else {
                            Image(systemName: "magnifyingglass")
                                .font(.title)
                            Text("No products found")
                            .font(.poppins(.medium, size: 20))
                        }
                    }
                    .foregroundStyle(Color.appTextSecondary)
                    .frame(maxHeight: .infinity,alignment: .center)
                    
                }else {
                    ProductsGridView(products: $productsVM.filteredItems, makeAPicall: {
                        Task {
                            await productsVM.getSSProductsData()
                        }
                    })
                }
                
                Spacer()
            }
        }
        .onAppear {
            Task {
                await productsVM.getSSProductsData()
            }
        }
        .alert(isPresented: $productsVM.showAlert) {
            Alert(title: Text(String.getAppName), message: Text(productsVM.message), dismissButton: .default(Text("Got it!")))
        }
    }
}
    
#Preview {
    ProductsHomeView()
}
