//
//  SeperatorView.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 17.02.2022.
//

import UIKit

final class SeperatorView: UIView {

    private lazy var seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(seperatorView)
        translatesAutoresizingMaskIntoConstraints = false
        seperatorView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 1),

            seperatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGuide.left),
            seperatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -LayoutGuide.right),
            seperatorView.topAnchor.constraint(equalTo: topAnchor),
            seperatorView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
