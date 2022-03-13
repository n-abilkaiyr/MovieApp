//
//  TrailerStackVIew.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 18.02.2022.
//

import UIKit

class TrailerVStackView: UIStackView {

    private var trailerURLs: [URL] = []
    private var names: [String] = []

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Трейлеры"
        label.font = Font.bold15
        label.textColor = Color.black
        return label
    }()

    func updateUI(with urls: [URL], and names: [String]) {

    }

    func setup() {
        addArrangedSubview(titleLabel)

        axis = .vertical
        distribution = .fill
        alignment = .fill
        spacing = 10
        isLayoutMarginsRelativeArrangement  = true
        layoutMargins = UIEdgeInsets(top: LayoutGuide.zero,
                                     left: LayoutGuide.left,
                                     bottom: LayoutGuide.zero,
                                     right: LayoutGuide.right)
        backgroundColor = .red
    }
}

// MARK: - UITableViewDataSource
