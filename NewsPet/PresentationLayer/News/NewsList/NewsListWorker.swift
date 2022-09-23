//
//  NewsListWorker.swift
//  NewsPet
//
//  Created by Damir Yackupov on 23.09.2022.
//

import NetworkLayer

final class NewsListWorker {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func getNewsList() async throws -> [NewsResponse] {
        let request = NewsRequestFactory.list.makeRequest()
        return try await networkClient.perform(request: request)
    }
}
