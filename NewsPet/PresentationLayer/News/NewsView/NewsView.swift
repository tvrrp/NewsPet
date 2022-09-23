//
//  NewsView.swift
//  NewsPet
//
//  Created by Damir Yackupov on 23.09.2022.
//

import UIKit
import UISystem

protocol NewsViewDisplayLogic: AnyObject {
    func update(with viewModel: NewsModule.GetNews.ViewModel)
}

final class NewsView: UIViewController {
    private let textLabel: Label = {
        let label = Label()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = AppLocalization.General.loading.localized
        label.isAccessibilityElement = true
        return label
    }()

    var interactor: NewsBusinessLogic?
    var router: NewsRoutingLogic?
    private var staticConstraints: [NSLayoutConstraint] = []

    private var textLabelConstraints: [NSLayoutConstraint] {
        let margins = view.layoutMarginsGuide
        return [
            textLabel.topAnchor.constraint(equalTo: margins.topAnchor),
            textLabel.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            textLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        ]
    }

    override func loadView() {
        view = View()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponents()
        setupActions()
        applyStyles()
        let request = NewsModule.GetNews.Request()
        interactor?.getNews(request: request)
    }

    override func updateViewConstraints() {
        if staticConstraints.isEmpty {
            staticConstraints = textLabelConstraints
            NSLayoutConstraint.activate(staticConstraints)
        }
        super.updateViewConstraints()
    }

    private func setupComponents() {
        navigationItem.title = AppLocalization.News.title.localized
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        view.addSubview(textLabel)
        view.setNeedsUpdateConstraints()
    }

    private func setupActions() { }

    private func applyStyles() {
        (view as? View)?.applyStyle(.basic)
        textLabel.applyStyle(.bigTitle)
    }
}

// MARK: - NewsViewDisplayLogic
extension NewsView: NewsViewDisplayLogic {
    func update(with viewModel: NewsModule.GetNews.ViewModel) {
        switch  viewModel.result {
        case let .success(news):
            UIView.animate(withDuration: 0.3) { [self] in
                textLabel.text = news.body
            }
        case let .failure(error):
            UIView.animate(withDuration: 0.3) { [self] in
                textLabel.text = error.localizedDescription
            }
        }
    }
}
