//
//  MoviewCrewVIew.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 17.02.2022.
//

import UIKit


final class MoviewCrewStackView: UIStackView {

    private lazy var actorsStackview: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [])
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 3
        return sv
    }()
    
    private lazy var directorsStackview: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [])
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 3
        return sv
    }()
    
    private lazy var producersStackview: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [])
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 3
        return sv
    }()
    
    private lazy var writersStackview: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [])
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 3
        return sv
    }()
    
    private lazy var rightStackview: UIStackView = {
        
        let sv = UIStackView(arrangedSubviews: [directorsStackview,
                                                producersStackview,
                                                writersStackview,
                                                UIView()])
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 20
        return sv
    }()
    
    private lazy var leftStackView: UIStackView = {
       
        let sv = UIStackView(arrangedSubviews: [actorsStackview, UIView()])
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 0
        return sv
    }()
    
    
    func setup() {
        addArrangedSubview(leftStackView)
        addArrangedSubview(rightStackview)
        
        axis = .horizontal
        distribution = .fillEqually
        alignment = .fill
        spacing = 10
        isLayoutMarginsRelativeArrangement  = true
        layoutMargins = UIEdgeInsets(top: LayoutGuide.zero,
                                     left: LayoutGuide.left,
                                     bottom: LayoutGuide.bottom,
                                     right: LayoutGuide.right)
    }
    
    
    func updateUI(with actors: [String], directors: [String], producers: [String], writers: [String]) {
        setupTitleLabel(for: actorsStackview)
        setupTitleLabel(for: directorsStackview)
        setupTitleLabel(for: producersStackview)
        setupTitleLabel(for: writersStackview)
        
        actors.forEach { setupNameLabel(with: $0, for: actorsStackview) }
        directors.forEach { setupNameLabel(with: $0, for: directorsStackview) }
        producers.forEach { setupNameLabel(with: $0, for: producersStackview) }
        writers.forEach { setupNameLabel(with: $0, for: writersStackview) }
    }
    
    private func setupNameLabel(with actorName: String, for stackView: UIStackView) {
        let label = UILabel()
        label.text = actorName
        label.font = Font.regular15
        label.textColor = Color.black
        stackView.addArrangedSubview(label)
    }
    
    private func setupTitleLabel(for stackView: UIStackView) {
        var title = ""
        switch stackView {
        case actorsStackview: title = "В главных ролях:"
        case directorsStackview: title = "Директор:"
        case producersStackview: title = "Продюсер:"
        default: title = "Сценарист:"}
        
        let label = UILabel()
        label.text = title
        label.font = Font.bold15
        label.textColor = Color.black
        stackView.addArrangedSubview(label)
    }
}

