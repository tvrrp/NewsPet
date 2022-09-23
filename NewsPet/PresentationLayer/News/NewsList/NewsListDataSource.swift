//
//  NewsListDataSource.swift
//  NewsPet
//
//  Created by Damir Yackupov on 23.09.2022.
//

import UIKit
import UISystem

final class NewsListDataSource: UITableViewDiffableDataSource<NewsListView.Section, NewsListView.Item> {
    init(tableView: UITableView) {
        super.init(tableView: tableView) { tableView, indexPath, item -> UITableViewCell? in
            let cell = tableView.dequeue(NewsListCell.self, for: indexPath)
            cell.update(with: item)
            return cell
        }
        defaultRowAnimation = .fade
        tableView.registerCellClass(NewsListCell.self)
    }
}
