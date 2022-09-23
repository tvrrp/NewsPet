//
//  NewsInteractor.swift
//  NewsPet
//
//  Created by Damir Yackupov on 23.09.2022.
//

protocol NewsBusinessLogic {
    func getNews(request: NewsModule.GetNews.Request)
}

final class NewsInteractor: NewsBusinessLogic {
    private var presenter: NewsPresentationLogic
    private var worker: NewsWorker

    init(presenter: NewsPresentationLogic, worker: NewsWorker) {
        self.presenter = presenter
        self.worker = worker
    }

    func getNews(request: NewsModule.GetNews.Request) {
        Task {
            let response: NewsModule.GetNews.Response
            do {
                let news = try await worker.getNews()
                if news.body == nil {
                    response = .init(result: .failure(.emptyNews))
                } else {
                    response = .init(result: .success(news))
                }
            } catch {
                response = .init(result: .failure(.unknown(error)))
            }
            presenter.update(with: response)
        }
    }
}
