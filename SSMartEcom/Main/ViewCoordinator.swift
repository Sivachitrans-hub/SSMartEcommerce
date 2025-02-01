//
//  ViewCoordinator.swift
//  SSMartEcom
//
//  Created by siva chitran p on 01/02/25.
//


import SwiftUI

struct ViewCoordinator: View {
    
    @State var splashActive : Bool = false
    
    @AppStorage(AppStorageKeys.isOnboardCompleted.rawValue) var isOnboardCompleted = false
    
    var body: some View {
        if splashActive {
            if isOnboardCompleted {
                ProductsHomeView()
            }else{
                OnboardView()
            }
        }else {
            SplashScreen(isActive: $splashActive)
        }
    }
}
