//
//  ViewCoordinator.swift
//  SSMartEcom
//
//  Created by siva chitran p on 01/02/25.
//


import SwiftUI

struct ViewCoordinator: View {
    
    @State var splashActive : Bool = false
    
    var body: some View {
        if splashActive {
            ProductsHomeView()
        }else {
            SplashScreen(isActive: $splashActive)
        }
    }
}
