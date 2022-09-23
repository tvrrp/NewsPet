//
//  NewsListCell.swift
//  NewsPet
//
//  Created by Damir Yackupov on 23.09.2022.
//

import UIKit
import UISystem

final class NewsListCell: TableCell {
    private let titleLabel: Label = {
        let label = Label()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.applyStyle(.smallTitle)
        return label
    }()

    private var staticConstraints: [NSLayoutConstraint] = []

    private var titleLabelConstraints: [NSLayoutConstraint] {
        return [
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20)
        ]
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
    }

    override func updateConstraints() {
        if staticConstraints.isEmpty {
            staticConstraints = titleLabelConstraints
            NSLayoutConstraint.activate(staticConstraints)
        }
        super.updateConstraints()
    }

    override func setupView() {
        isAccessibilityElement = true
        accessibilityTraits = .button

        backgroundColor = .clear
        selectionStyle = .none

        contentView.backgroundColor = .clear
        contentView.addSubview(titleLabel)

        setNeedsUpdateConstraints()
    }

    func update(with item: NewsListView.Item) {
        titleLabel.text = item.title
        accessibilityLabel = item.title
    }
}
