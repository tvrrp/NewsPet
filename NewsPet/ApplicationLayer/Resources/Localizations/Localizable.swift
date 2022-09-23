//
//  Localizable.swift
//  NewsPet
//
//  Created by Damir Yackupov on 23.09.2022.
//

import Foundation

protocol Localizable: RawRepresentable { }

extension Localizable {
    var key: String {
        return rawValue as? String ?? ""
    }

    var localized: String {
        return NSLocalizedString(key, comment: "")
    }
}
