//
//  CollectionViewCells.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 08.02.2022.
//

import UIKit

protocol MovieCollectionViewCellViewModelProtocol {
    var movieName: String { get }
    var status: MovieStatus { get }
    func fetchImageData(completeion: @escaping (Data) -> Void)
}

final class MovieCollectionViewCell: UICollectionViewCell {
    
    var collectionCellViewModel: MovieCollectionViewCellViewModelProtocol?

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.startAnimating()
        indicator.style = .medium
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var frontView: UIView = {
        let view = UIView()
        return view
    }()
    private lazy var movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.backgroundColor =  .lightGray.withAlphaComponent(0.2)
        return imageView
    }()
    
    private lazy var movieNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = Font.medium15
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [movieImage, movieNameLabel])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImage.image = nil
        movieNameLabel.text = nil
    }
    
    private func setup() {
        contentView.backgroundColor =  Color.backgroundColor
        
        contentView.addSubview(vStackView)
        contentView.addSubview(frontView)
        contentView.addSubview(activityIndicator)
        
        [vStackView, frontView, activityIndicator].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        vStackView.backgroundColor = Color.backgroundColor
        frontView.backgroundColor = .clear
        activityIndicator.color = .darkGray
        
        NSLayoutConstraint.activate([
            vStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            vStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            vStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            frontView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            frontView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            frontView.topAnchor.constraint(equalTo: contentView.topAnchor),
            frontView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            vStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            vStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            vStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: 50),
            activityIndicator.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}



// MARK: - Public methods
extension MovieCollectionViewCell {
    
    func configure(with viewModel: MovieCollectionViewCellViewModelProtocol?) {
        collectionCellViewModel = viewModel
        guard let collectionCellViewModel = collectionCellViewModel else { return }
        
        movieNameLabel.isHidden = collectionCellViewModel.status == .nowPlaying
        movieNameLabel.text = collectionCellViewModel.movieName
        collectionCellViewModel.fetchImageData(completeion: { data in
            self.activityIndicator.stopAnimating()
            self.movieImage.image = UIImage(data: data)
        })
    }
    
    func itemIsSelected(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) {
            self.frontView.backgroundColor = .white.withAlphaComponent(0.5)
        } completion: { _ in
            UIView.animate(withDuration: 0.1) {
                self.frontView.backgroundColor = .clear
                completion()
            } 
        }
    }
}
