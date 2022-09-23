//
//  NewsRequestFactory.swift
//  NewsPet
//
//  Created by Damir Yackupov on 23.09.2022.
//

import Foundation

enum NewsRequestFactory {
    case list
    case item(newsId: Int)

    private var method: String {
        switch self {
        case .list,
             .item:
            return "GET"
        }
    }

    private var path: String {
        switch self {
        case .list:
            return "/posts"
        case let .item(newsId):
            return "/posts/\(newsId)"
        }
    }

    func makeRequest() -> URLRequest {
        let url = URL(string: AppConfiguration.serverUrl) ?? URL(fileURLWithPath: "")
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method
        request.timeoutInterval = 10
        return request
    }
}
