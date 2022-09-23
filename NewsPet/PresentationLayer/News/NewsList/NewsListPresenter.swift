//
//  NewsListPresenter.swift
//  NewsPet
//
//  Created by Damir Yackupov on 23.09.2022.
//

import UIKit

protocol NewsListPresentationLogic {
    func update(with response: NewsListModule.GetNewsList.Response)
    func update(with response: NewsListModule.OpenNews.Response)
}

final class NewsListPresenter: NewsListPresentationLogic {
    private weak var viewController: NewsListViewDisplayLogic?

    init(viewController: NewsListViewDisplayLogic) {
        self.viewController = viewController
    }

    func update(with response: NewsListModule.GetNewsList.Response) {
        switch response.result {
        case let .success(newsResponses):
            var snapshot = NSDiffableDataSourceSnapshot<NewsListView.Section, NewsListView.Item>()
            snapshot.appendSections([.main])
            let items = newsResponses.map { NewsListView.Item(newsId: $0.id, title: $0.title) }
            snapshot.appendItems(items)
            let viewModel = NewsListModule.GetNewsList.ViewModel(result: .success(snapshot))
            Task { @MainActor in
                viewController?.update(with: viewModel)
            }
        case let .failure(error):
            let viewModel = NewsListModule.GetNewsList.ViewModel(result: .failure(error))
            Task { @MainActor in
                viewController?.update(with: viewModel)
            }
        }
    }

    func update(with response: NewsListModule.OpenNews.Response) {
        let viewModel = NewsListModule.OpenNews.ViewModel(newsId: response.newsId)
        Task { @MainActor in
            viewController?.update(with: viewModel)
        }
    }
}
