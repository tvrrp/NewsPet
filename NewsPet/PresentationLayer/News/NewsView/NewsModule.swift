//
//  NewsModule.swift
//  NewsPet
//
//  Created by Damir Yackupov on 23.09.2022.
//

import Foundation

enum NewsModule {
    enum GetNews {
        struct Request { }

        struct Response {
            let result: Result<NewsResponse, Error>
        }

        struct ViewModel {
            let result: Result<News, Error>
        }
    }

    struct News {
        let id: Int
        let body: String
    }

    enum Error: LocalizedError {
        case emptyNews
        case unknown(_ error: Swift.Error?)

        var errorDescription: String? {
            switch self {
            case .emptyNews:
                return AppLocalization.Error.News.emptyNews.localized
            case let .unknown(error):
                return error?.localizedDescription ?? AppLocalization.Error.unknown.localized
            }
        }
    }
}
