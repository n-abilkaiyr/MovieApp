//
//  WrapperView.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 18.02.2022.
//

import UIKit

final class WrapperView: UIView {
    private var subView: UIView
    
    init(with subView: UIView) {
        self.subView = subView
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGuide.left),
            subView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -LayoutGuide.right),
            subView.topAnchor.constraint(equalTo: topAnchor),
            subView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
