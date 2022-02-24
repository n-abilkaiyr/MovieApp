//
//  MovieTableViewCell.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 09.02.2022.
//

import UIKit
protocol MovieTableViewCellViewModelProtocol {
    var movies: [Movie] { get set }
    var status: MovieStatus! { get }
    var statusName: String { get }
    init(movies: [Movie], status: MovieStatus)
    func collectionCellViewModel(for indexPath: IndexPath) -> MovieCollectionViewCellViewModelProtocol?
    func viewModelForSelectedItem(selectedRow: Int) -> DetailMovieViewControllerViewModelProtocol
}

final class MovieTableViewCell: UITableViewCell {

    weak var delegate: MovieListDelegate?

    private var status: MovieStatus?
    private var movies: [Movie] = []
    private var cellViewModel: MovieTableViewCellViewModelProtocol?

    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = Font.bold25
        label.textColor = Color.black
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
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.register(MovieCollectionViewCell.self)
        collectionView.backgroundColor = Color.backgroundColor
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [wrapperView, collectionView ])
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

    func configure(with vieModel: MovieTableViewCellViewModelProtocol?) {
        cellViewModel = vieModel
        guard let cellViewModel = cellViewModel else { return }

        statusLabel.text = cellViewModel.statusName
        movies = cellViewModel.movies
        status = cellViewModel.status
        collectionView.reloadData()
    }

    private func setup() {
        wrapperView.addSubview(statusLabel)
        contentView.addSubview(vStackView)

        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: wrapperView.topAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: LayoutGuide.left),
            statusLabel.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor)
        ])

        vStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutGuide.top),
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
        let cell = collectionView.dequeueReusableCell(with: MovieCollectionViewCell.self, for: indexPath)
        let viewModel = cellViewModel?.collectionCellViewModel(for: indexPath)
        cell.configure(with: viewModel)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension MovieTableViewCell: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = collectionView.cellForItem(at: indexPath) as? MovieCollectionViewCell {
            item.itemIsSelected {
                guard let viewModel =  self.cellViewModel else { return }
                let detailMovieViewModel = viewModel.viewModelForSelectedItem(selectedRow: indexPath.row)
                let detailMovieController = DetailMovieViewController(viewModel: detailMovieViewModel)
                self.delegate?.present(viewController: detailMovieController)
            }
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MovieTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if status == .nowPlaying {
            return CGSize(width: collectionView.frame.width / 1.7, height: collectionView.frame.height)
        }

        return CGSize(width: collectionView.frame.width * 0.7, height: collectionView.frame.height)
    }
}
