//
//  Extensions.swift
//  SSMartEcom
//
//  Created by siva chitran p on 01/02/25.
//

import Foundation
import UIKit

extension String {
    
    static var getAppName: String  {
        guard let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? Self else {
            return ""
        }
        return bundleName
    }
}
extension CGFloat {
    static var width = UIScreen.main.bounds.width
    static var height = UIScreen.main.bounds.height
}
