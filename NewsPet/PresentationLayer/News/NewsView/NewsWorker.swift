//
//  NewsWorker.swift
//  NewsPet
//
//  Created by Damir Yackupov on 23.09.2022.
//

import NetworkLayer

final class NewsWorker {
    private let newsId: Int
    private let networkClient: NetworkClient

    init(newsId: Int, networkClient: NetworkClient) {
        self.newsId = newsId
        self.networkClient = networkClient
    }

    func getNews() async throws -> NewsResponse {
        let request = NewsRequestFactory.item(newsId: newsId).makeRequest()
        return try await networkClient.perform(request: request)
    }
}
