//
//  MovieInfoView.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 17.02.2022.
//

import UIKit

final class MoviewInfoStackView: UIStackView {
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = Font.regular15
        label.textColor = Color.black
        return label
    }()

    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = Font.regular15
        label.textColor = Color.black
        return label
    }()

    private lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = Font.regular15
        label.textColor = Color.black
        label.setContentHuggingPriority(UILayoutPriority(249), for: .horizontal)
        return label
    }()

    private lazy var movieInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [genreLabel, yearLabel, durationLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()

    private lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Font.regular15
        label.textColor = Color.black
        return label
    }()

    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = Font.regular15
        label.textColor = Color.black
        return label
    }()

    private lazy var scocreLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = Font.medium15
        label.textColor = Color.black
        label.setContentHuggingPriority(UILayoutPriority(249), for: .horizontal)
        return label
    }()

    private lazy var ratingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ratingLabel, scocreLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()

    func setup() {
        addArrangedSubview(movieInfoStackView)
        addArrangedSubview(overviewLabel)
        addArrangedSubview(ratingStackView)

        axis = .vertical
        distribution = .fill
        alignment = .fill
        spacing = 10
        isLayoutMarginsRelativeArrangement  = true
        layoutMargins = UIEdgeInsets(top: LayoutGuide.zero,
                                     left: LayoutGuide.left,
                                     bottom: LayoutGuide.bottom,
                                     right: LayoutGuide.right)

     }

     func updateUI(with values: String... ) {
        let views = [genreLabel, yearLabel, durationLabel, overviewLabel, ratingLabel, scocreLabel]

        for (index, value) in values.enumerated() {
            views[index].text = value
        }
    }
}
