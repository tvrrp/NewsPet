//
//  NewsListInteractor.swift
//  NewsPet
//
//  Created by Damir Yackupov on 23.09.2022.
//

protocol NewsListBusinessLogic {
    func getNewsList(with request: NewsListModule.GetNewsList.Request)
    func openNews(with request: NewsListModule.OpenNews.Request)
}

final class NewsListInteractor: NewsListBusinessLogic {
    private var presenter: NewsListPresentationLogic
    private var worker: NewsListWorker

    init(presenter: NewsListPresentationLogic, worker: NewsListWorker) {
        self.presenter = presenter
        self.worker = worker
    }

    func getNewsList(with request: NewsListModule.GetNewsList.Request) {
        Task {
            let response: NewsListModule.GetNewsList.Response
            do {
                let news = try await worker.getNewsList()
                response = .init(result: .success(news))
                presenter.update(with: response)
            } catch {
                response = .init(result: .failure(.unknown(error)))
                presenter.update(with: response)
            }
        }
    }

    func openNews(with request: NewsListModule.OpenNews.Request) {
        let response = NewsListModule.OpenNews.Response(newsId: request.newsId)
        presenter.update(with: response)
    }
}
