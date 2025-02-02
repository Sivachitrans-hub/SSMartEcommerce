//
//  FontHandler.swift
//  SSMartEcom
//
//  Created by siva chitran p on 01/02/25.
//

import SwiftUI

extension Font {
    
    enum Poppins {
        case regular
        case medium
        case semibold
        case bold
        
        var value : String {
            switch self {
            case .regular:
                return "Poppins-Regular"
            case .medium:
                return "Poppins-Medium"
            case .semibold:
                return "Poppins-SemiBold"
            case .bold:
                return "Poppins-Bold"
            }
        }
    }
    
    static func poppins(_ type : Poppins,size : CGFloat = 13) -> Font {
        return .custom(type.value, size: size)
    }
}

