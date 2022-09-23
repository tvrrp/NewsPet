//
//  NewsFactory.swift
//  NewsPet
//
//  Created by Damir Yackupov on 23.09.2022.
//

import NetworkLayer

final class NewsFactory {
    private let newsId: Int

    init(newsId: Int) {
        self.newsId = newsId
    }

    func create() -> NewsView {
        let viewController = NewsView()
        let presenter = NewsPresenter(viewController: viewController)
        let networkClient = DefaultNetworkClient()
        let worker = NewsWorker(newsId: newsId, networkClient: networkClient)
        let interactor = NewsInteractor(presenter: presenter, worker: worker)
        viewController.interactor = interactor
        let router = NewsRouter(viewController: viewController)
        viewController.router = router
        return viewController
    }
}
