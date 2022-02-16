//
//  MovieTableViewCell.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 09.02.2022.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    static let identifier = "moviesCell"
    
    var cellViewModel: MovieTableViewCellViewModelProtocol! {
        didSet {
            statusLabel.text = cellViewModel.statusName
            movies = cellViewModel.movies
            status = cellViewModel.status
            collectionView.reloadData()
        }
    }
    
    private var movies = [Movie]()
    private var status: MovieStatus!

    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = Font.movieStausFont
        label.textColor = Color.movieStausColor
        return label
    }()
    
    private lazy var wrapperView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        collectionView.backgroundColor = Color.backgroundColor
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [wrapperView,collectionView ])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8
        stackView.backgroundColor =  Color.backgroundColor
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        wrapperView.addSubview(statusLabel)
        contentView.addSubview(vStackView)
        
        
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
       
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: wrapperView.topAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 16),
            statusLabel.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor)
        ])
        
//        vStackView.addArrangedSubview(statusLabel)
//        vStackView.addSubview(collectionView)
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            vStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            vStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}


// MARK: - UICollectionViewDataSource
extension MovieTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as!  MovieCollectionViewCell
        cell.collectionCellViewModel = cellViewModel.collectionCellViewModel(for: indexPath)
        
        return cell
    }
}

// MARK: - UICollectionViewDataSource
extension MovieTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     
        print("Row \(indexPath.row) pressed.")
    }
    
}
// MARK: - UICollectionViewDelegateFlowLayout
extension MovieTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if status == .nowPlaying {
            return CGSize(width: collectionView.frame.width / 1.7 , height: collectionView.frame.height)
        }
        
        return CGSize(width: collectionView.frame.width * 0.7 , height: collectionView.frame.height)
    }
    
}
