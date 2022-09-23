//
//  NewsListModule.swift
//  NewsPet
//
//  Created by Damir Yackupov on 23.09.2022.
//

import Foundation
import UIKit

enum NewsListModule {
    enum GetNewsList {
        struct Request { }

        struct Response {
            let result: Result<[NewsResponse], Error>
        }

        struct ViewModel {
            let result: Result<NSDiffableDataSourceSnapshot<NewsListView.Section, NewsListView.Item>, Error>
        }
    }

    enum OpenNews {
        struct Request {
            let newsId: Int
        }

        struct Response {
            let newsId: Int
        }

        struct ViewModel {
            let newsId: Int
        }
    }

    enum Error: LocalizedError {
        case unknown(Swift.Error?)

        var errorDescription: String? {
            switch self {
            case let .unknown(error):
                return error?.localizedDescription ?? AppLocalization.Error.unknown.localized
            }
        }
    }
}
