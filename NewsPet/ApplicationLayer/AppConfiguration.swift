//
//  AppConfiguration.swift
//  NewsPet
//
//  Created by Damir Yackupov on 23.09.2022.
//

import Foundation

enum AppConfiguration {
    static var serverUrl: String {
        guard let serverUrl = Bundle.main.infoDictionary?["ServerUrl"] as? String else {
            return ""
        }
        return serverUrl
    }
}
