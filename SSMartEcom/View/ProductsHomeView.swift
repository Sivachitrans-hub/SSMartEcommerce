//
//  ProductsHomeView.swift
//  SSMartEcom
//
//  Created by siva chitran p on 01/02/25.
//


import SwiftUI


struct ProductsHomeView: View {
    
    @State private var searchText = ""
    @ObservedObject var productsVM = ProductsViewModel()
    
    
    var body: some View {
        ZStack {
            Color(.appBgPrimary)
                .ignoresSafeArea()
            VStack {
                ProductsHeaderView()
                ProductsSearchView(searchText: $searchText, productItems: $productsVM.products)
                ProductsGridView(products: $productsVM.products)
                Spacer()
            }.onAppear {
                Task {
                    await productsVM.getSSProductsData()
                }
            }
            .alert(isPresented: $productsVM.showAlert) {
                Alert(title: Text(String.getAppName), message: Text(productsVM.message), dismissButton: .default(Text("Got it!")))
            }
        }
    }
}
    
#Preview {
    ProductsHomeView()
}


struct ProductsGridView : View {
    
    @Binding var products : [ProductsModel]
    @ObservedObject var productsVM = ProductsViewModel()
    
    let columns = [
        GridItem(.flexible(), spacing: 5),
        GridItem(.flexible(), spacing: 5)
    ]
    

    var body: some View {
        
        GeometryReader { gridViewSizes in
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(products, id: \.id) { item in
                        SSMartEcomGridViewCell(product: item)
                    }
                }
                .padding()
            }
            .frame(width: gridViewSizes.size.width, height: gridViewSizes.size.height)
            .refreshable {
                Task {
                    await pullToRefresh()
                }
               
            }
        }
       
    }
    func pullToRefresh() async {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
       // await productsVM.getSSProductsData()
    }
}
     

//MARK: - Add the grid view custom cell as ReuseableCell
struct SSMartEcomGridViewCell : View {
     var product : ProductsModel
    
    
    var body : some View {
        VStack(spacing: 5) {
            AsyncImage(url: URL(string: product.image ?? "")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
                .scaledToFit()
                .frame(width:150,height: 100)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(product.title ?? "")
                    .font(.poppins(.semibold, size: 16))
                    .foregroundColor(.black)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                
                Text(product.category ?? "")
                    .font(.poppins(.medium, size: 15))
                    .foregroundStyle(.appTextSecondary)
            }.padding(.top,10)
            
            HStack {
                StarRating(rating: .constant(2.5), maxRating: 5)
                Spacer() // Pushes price to right side
                
                Text("(\(product.rating?.count ?? 0))")
                    .font(.poppins(.medium, size: 10))
                    .foregroundStyle(.secondary)
                
            }
            .padding(.horizontal, 0) // Add padding for better spacing
            .padding(.vertical,10)
            Color.clear.frame(width: 30, height: 0)
            
            
            Text("Price : \(String(format: "%.2f", product.price ?? 0))")
            
                .foregroundStyle(.appTheme)
                .padding(.vertical,10)
                .frame(maxWidth: .infinity)
                .overlay {
                    RoundedRectangle(cornerRadius: 10).stroke(.appTheme, lineWidth: 0.5)
                }
        }
        .padding()
        .background(.appBgSecondary)
        .cornerRadius(12)
    }
    
}
    
//MARK: - Add Rating View

struct StarRating: View {
    struct ClipShape: Shape {
        let width: Double
        
        func path(in rect: CGRect) -> Path {
            Path(CGRect(x: rect.minX, y: rect.minY, width: width, height: rect.height))
        }
    }
    
    @Binding var rating: Double
    let maxRating: Int
    
    init(rating: Binding<Double>, maxRating: Int) {
        self.maxRating = maxRating
        self._rating = rating
    }
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<maxRating, id: \.self) { _ in
                Text(Image(systemName: "star"))
                    .foregroundColor(.yellow)
                    .aspectRatio(contentMode: .fill)
            }
        }.overlay(
            GeometryReader { reader in
                HStack(spacing: 0) {
                    ForEach(0..<maxRating, id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .aspectRatio(contentMode: .fill)
                    }
                }
                .clipShape(
                    ClipShape(width: (reader.size.width / CGFloat(maxRating)) * CGFloat(rating))
                )
            }
        )
    }
}

//MARK: - Add The pull to refresh using asyc wait






#Preview {
   
}
    
    
    
    

