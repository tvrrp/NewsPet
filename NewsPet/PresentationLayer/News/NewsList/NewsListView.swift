//
//  NewsListView.swift
//  NewsPet
//
//  Created by Damir Yackupov on 23.09.2022.
//

import UIKit
import UISystem

protocol NewsListViewDisplayLogic: AnyObject {
    func update(with viewModel: NewsListModule.GetNewsList.ViewModel)
    func update(with viewModel: NewsListModule.OpenNews.ViewModel)
}

final class NewsListView: UIViewController {
    enum Section {
        case main
    }

    struct Item: Hashable {
        let newsId: Int
        let title: String

        func hash(into hasher: inout Hasher) {
            hasher.combine(newsId)
            hasher.combine(title)
        }

        static func == (lhs: Item, rhs: Item) -> Bool {
            return lhs.newsId == rhs.newsId && lhs.title == rhs.title
        }
    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        dataSource = NewsListDataSource(tableView: tableView)
        tableView.dataSource = dataSource
        tableView.delegate = self
        return tableView
    }()

    var interactor: NewsListBusinessLogic?
    var router: NewsListRoutingLogic?
    private var dataSource: UITableViewDiffableDataSource<Section, Item>?
    private var staticConstraints: [NSLayoutConstraint] = []

    private var tableViewConstraints: [NSLayoutConstraint] {
        let safeArea = view.safeAreaLayoutGuide
        return [
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
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
        let request = NewsListModule.GetNewsList.Request()
        interactor?.getNewsList(with: request)
    }

    override func updateViewConstraints() {
        if staticConstraints.isEmpty {
            staticConstraints = tableViewConstraints
            NSLayoutConstraint.activate(staticConstraints)
        }
        super.updateViewConstraints()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard traitCollection.preferredContentSizeCategory
                != previousTraitCollection?.preferredContentSizeCategory else { return }
        Task { @MainActor in
            tableView.reloadData()
        }
    }

    private func setupComponents() {
        navigationItem.title = AppLocalization.NewsList.title.localized
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        view.addSubview(tableView)
        view.setNeedsUpdateConstraints()
    }

    private func setupActions() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(getNewsList), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    private func applyStyles() {
        (view as? View)?.applyStyle(.basic)
        tableView.backgroundColor = .clear
    }
}

// MARK: - Actions
extension NewsListView {
    @objc private func getNewsList() {
        let request = NewsListModule.GetNewsList.Request()
        interactor?.getNewsList(with: request)
    }
}

// MARK: - NewsListViewDisplayLogic
extension NewsListView: NewsListViewDisplayLogic {
    func update(with viewModel: NewsListModule.GetNewsList.ViewModel) {
        switch viewModel.result {
        case let .success(snapshot):
            dataSource?.apply(snapshot, animatingDifferences: true)
        case let .failure(error):
            router?.presentAlert(error: error)
        }
        Task.delayed(byTimeInterval: 1) { @MainActor [weak tableView] in
            tableView?.refreshControl?.endRefreshing()
        }
    }

    func update(with viewModel: NewsListModule.OpenNews.ViewModel) {
        router?.routeToNews(newsId: viewModel.newsId)
    }
}

// MARK: - UITableViewDelegate
extension NewsListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = dataSource?.itemIdentifier(for: indexPath) else { return }
        let request = NewsListModule.OpenNews.Request(newsId: item.newsId)
        interactor?.openNews(with: request)
    }
}
