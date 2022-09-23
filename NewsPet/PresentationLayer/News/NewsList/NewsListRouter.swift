//
//  NewsListRouter.swift
//  NewsPet
//
//  Created by Damir Yackupov on 23.09.2022.
//

import UIKit

protocol NewsListRoutingLogic {
    func routeToNews(newsId: Int)
    func presentAlert(error: Error)
}

final class NewsListRouter: NewsListRoutingLogic {
    private weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func routeToNews(newsId: Int) {
        let factory = NewsFactory(newsId: newsId)
        let vc = factory.create()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }

    func presentAlert(error: Error) {
        let title = AppLocalization.General.error.localized
        let message = error.localizedDescription
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let action = UIAlertAction(title: AppLocalization.General.ok.localized, style: .default)
        alertController.addAction(action)

        viewController?.present(alertController, animated: true)
    }
}
