//
//  SSMartEcomGridViewCell.swift
//  SSMartEcom
//
//  Created by siva chitran p on 02/02/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct SSMartEcomGridViewCell : View {
     var product : ProductsModel
    
    var body : some View {
        VStack(spacing: 5) {
            
            WebImage(url: URL(string: product.image ?? ""),options: [.refreshCached]) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .scaledToFit()
            .frame(width:150,height: 100)
            .cornerRadius(10)
            .padding(.top,15)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(product.title ?? "")
                    .font(.poppins(.semibold, size: 16))
                    .foregroundColor(.appTextPrimary)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                
                Text(product.category ?? "")
                    .font(.poppins(.medium, size: 15))
                    .foregroundStyle(.appTextSecondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.top,10)
            .padding(.horizontal)
            
            
            HStack(spacing: 0) {
                StarRatingView(rating: .constant(2.5), maxRating: 5)
                Spacer() // Pushes price to right side
                
                Text("(\(product.rating?.count ?? 0))")
                    .font(.poppins(.medium, size: 10))
                    .foregroundStyle(.secondary)
                
            }
            
            .padding(.top,10)
            .padding(.horizontal)

            Text("Price : \(String(format: "%.2f", product.price ?? 0))")
                .lineLimit(1)
                .padding(.vertical,10)
                .foregroundStyle(.appTheme)
                .frame(maxWidth: .infinity)
                .overlay {
                    RoundedRectangle(cornerRadius: 10).stroke(.appTheme, lineWidth: 0.5)
                }
                .padding(.vertical,10)
                .padding(.horizontal)
            
        }
        
        
        .background(.appBgSecondary)
        .cornerRadius(12)
       
        
    }
    
}
