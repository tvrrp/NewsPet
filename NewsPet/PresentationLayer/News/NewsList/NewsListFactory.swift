//
//  NewsListFactory.swift
//  NewsPet
//
//  Created by Damir Yackupov on 23.09.2022.
//

import NetworkLayer

final class NewsListFactory {
    init() { }

    func create() -> NewsListView {
        let viewController = NewsListView()
        let presenter = NewsListPresenter(viewController: viewController)
        let networkClient = DefaultNetworkClient()
        let worker = NewsListWorker(networkClient: networkClient)
        let interactor = NewsListInteractor(presenter: presenter, worker: worker)
        viewController.interactor = interactor
        viewController.router = NewsListRouter(viewController: viewController)
        return viewController
    }
}
