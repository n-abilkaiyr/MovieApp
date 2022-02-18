//
//  TrailerView.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 18.02.2022.
//

import UIKit

final class TrailerHStackView: UIStackView {
    var urlToVideo: URL?
    var completion: ((URL) -> Void)?
    
    private lazy var trailerLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.black
        label.font = Font.medium15
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var playImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "play.circle.fill")
        imageView.tintColor = .systemBlue
        return imageView
    }()
    
    private lazy var wrapperView: UIView = {
        let view = UIView()
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        addArrangedSubview(trailerLabel)
        addArrangedSubview(playImageView)

        axis = .horizontal
        distribution = .fill
        alignment = .center
        spacing = 30
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(trailerTapped))
        addGestureRecognizer(gesture)
        playImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playImageView.heightAnchor.constraint(equalToConstant: 20),
            playImageView.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func updateUI(with name: String, and url: URL ) {
        self.urlToVideo = url
        trailerLabel.text = name
    }
    
    @objc private func trailerTapped() {
        animateView()
        
    }
    
    private func animateView() {
        UIView.animate(withDuration: 0.2) {
            self.superview?.backgroundColor = .lightGray.withAlphaComponent(0.5)
        } completion: { _ in
            self.superview?.backgroundColor = .clear
            guard let url = self.urlToVideo else { return }
            self.completion?(url)
        }
    }
}
