//
//  AppLocalization.swift
//  NewsPet
//
//  Created by Damir Yackupov on 23.09.2022.
//

import Foundation

enum AppLocalization {
    enum General: String, Localizable {
        case ok = "OK"
        case save = "Save"
        case cancel = "Cancel"
        case close = "Close"
        case unknown = "Unknown"
        case loading = "Loading"
        case refresh = "Refresh"
        case tryAgain = "TryAgain"
        case error = "Error"
    }

    enum Error: String, Localizable {
        case unknown = "UnknownError"

        enum News: String, Localizable {
            case emptyNews = "EmptyNewsError"
        }
    }

    enum NewsList: String, Localizable {
        case title = "NewsListTitle"
    }

    enum News: String, Localizable {
        case title = "NewsTitle"
    }
}
