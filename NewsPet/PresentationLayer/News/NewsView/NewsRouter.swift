//
//  NewsRouter.swift
//  NewsPet
//
//  Created by Damir Yackupov on 23.09.2022.
//

import UIKit

protocol NewsRoutingLogic { }

final class NewsRouter: NewsRoutingLogic {
    private weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}
