//
//  DetailMovieViewController.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 14.02.2022.
//

import UIKit
import SafariServices

final class DetailMovieViewController: UIViewController {

    private var viewModel: DetailMovieViewControllerViewModelProtocol

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = Color.backgroundColor
        return scrollView
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    private lazy var movieInfoStackView: MoviewInfoStackView = {
        let stackView = MoviewInfoStackView()
        stackView.setup()
        return stackView
    }()

    private lazy var movieCrewStackView: MoviewCrewStackView = {
        let stackView = MoviewCrewStackView()
        stackView.setup()
        return stackView
    }()

    private lazy var trailerStackView: TrailerVStackView = {
        let stackView = TrailerVStackView()
        stackView.setup()
        return stackView
    }()

    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView,
                                                movieInfoStackView,
                                                SeperatorView(),
                                                movieCrewStackView,
                                                SeperatorView(),
                                                trailerStackView])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()

    init(viewModel: DetailMovieViewControllerViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        trailerStackView.completion = { url in self.openVideo(by: url) }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        view.backgroundColor = Color.backgroundColor
        viewModel.fetchMovie {
            self.configureViews()
            self.updateUI()
            self.viewModel.fetchImageData { data in
                self.imageView.image = UIImage(data: data)
            }
        }
    }

    private func updateUI() {
        title = viewModel.movieName
        movieInfoStackView.updateUI(with: viewModel.genreText,
                                          viewModel.yearText,
                                          viewModel.durationText,
                                          viewModel.overViewText,
                                          viewModel.ratingText,
                                          viewModel.scoreText)

        movieCrewStackView.updateUI(with: viewModel.crew,
                                    directors: viewModel.directors,
                                    producers: viewModel.producers,
                                    writers: viewModel.writers)

        trailerStackView.updateUI(with: viewModel.youtubeURLs, and: viewModel.trailerNames)
    }

    private func configureViews() {

        scrollView.addSubview(mainStackView)
        view.addSubview(scrollView)

        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: Font.bold20]

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),

            mainStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1.0)
        ])

        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])

    }

    private func openVideo(by url: URL) {
        let config = SFSafariViewController.Configuration()
        let safariViewController = SFSafariViewController(url: url, configuration: config)
        safariViewController.modalPresentationStyle = .fullScreen
        present(safariViewController, animated: true)
    }
}
