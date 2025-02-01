struct ProductsSearchView : View {
   
    @Binding  var searchText : String
    
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