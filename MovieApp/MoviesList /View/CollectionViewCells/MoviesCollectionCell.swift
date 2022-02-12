//
//  CollectionViewCells.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 08.02.2022.
//

import UIKit


class MovieCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "moviesCollectionCell"
    
    var collectionCellViewModel: MovieCollectionViewCellViewModelProtocol! {
        didSet {
            configure(with: collectionCellViewModel.status)
            movieNameLabel.text = collectionCellViewModel.movieName
            collectionCellViewModel.fetchImageData(completeion: { data in
            self.movieImage.image = UIImage(data: data)
            })
        }
    }
    
    private lazy var movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var movieNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = Font.movieNameFont
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
    
   
    
    private func configure(with staus: MovieStatus) {
        movieNameLabel.isHidden = staus == .nowPlaying
        movieNameLabel.insetsLayoutMarginsFromSafeArea = true
        movieNameLabel.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        contentView.backgroundColor =  Color.backgroundColor
        contentView.addSubview(vStackView)
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            vStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            vStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    
    }
}
