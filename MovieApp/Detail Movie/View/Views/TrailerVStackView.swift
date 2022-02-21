//
//  TrailerStackVIew.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 18.02.2022.
//

import UIKit

final class TrailerVStackView: UIStackView {

    var completion: ((URL) -> Void)?

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Трейлеры"
        label.font = Font.bold15
        label.textColor = Color.black
        return label
    }()

    private lazy var notAvailableLabel: UILabel = {
        let label = UILabel()
        label.text = "n/a"
        label.font = Font.regular15
        label.textColor = Color.black
        return label
    }()

    func updateUI(with urls: [URL], and names: [String]) {

        if names.isEmpty {
            let wrapperView = WrapperView(with: notAvailableLabel)
            addArrangedSubview(wrapperView)
            return
        }

        for index in 0..<names.count {
            let hStackView = TrailerHStackView()
            hStackView.completion = completion
            let name = names[index]
            let url = urls[index]
            hStackView.updateUI(with: name, and: url)
            let wrapperView = WrapperView(with: hStackView)
            addArrangedSubview(wrapperView)
        }
    }

    func setup() {
        let wrapperView = WrapperView(with: titleLabel)
        addArrangedSubview(wrapperView)

        axis = .vertical
        distribution = .fillEqually
        alignment = .fill
        spacing = 10

    }
}
