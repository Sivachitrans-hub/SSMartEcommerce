struct ProductsHeaderView : View {
    var body: some View {
        Text("Saravana Store Products")
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding()
            .font(.poppins(.bold, size: 25))
            .foregroundStyle(.appTextPrimary)
    }
}