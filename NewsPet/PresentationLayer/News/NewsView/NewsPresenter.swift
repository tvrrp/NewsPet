//
//  NewsPresenter.swift
//  NewsPet
//
//  Created by Damir Yackupov on 23.09.2022.
//

import Foundation

protocol NewsPresentationLogic {
    func update(with response: NewsModule.GetNews.Response)
}

final class NewsPresenter: NewsPresentationLogic {
    private weak var viewController: NewsViewDisplayLogic?

    init(viewController: NewsViewDisplayLogic) {
        self.viewController = viewController
    }

    func update(with response: NewsModule.GetNews.Response) {
        let viewModel: NewsModule.GetNews.ViewModel
        switch response.result {
        case .success(let newsResponse):
            if let body = newsResponse.body {
                let news = NewsModule.News(id: newsResponse.id, body: body)
                viewModel = .init(result: .success(news))
            } else {
                viewModel = .init(result: .failure(.emptyNews))
            }
        case .failure(let error):
            viewModel = .init(result: .failure(.unknown(error)))
        }
        Task { @MainActor in
            viewController?.update(with: viewModel)
        }
    }
}
