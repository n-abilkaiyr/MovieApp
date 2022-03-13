//
//  AppCoordinator.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 07.03.2022.
//

import UIKit
import SafariServices

protocol MovieListNavigation: AnyObject {
    func goToMovieListPage()
}

protocol MovieDetailNavigaiton: AnyObject {
    func goToDetailPage(with viewModel: DetailMovieViewControllerViewModelProtocol)
}

protocol TrailerNavigation: AnyObject {
    func openYoutubeVideo(by url: URL)
}

class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navCon: UINavigationController) {
        self.navigationController = navCon
    }
    
    func start() {
        goToMovieListPage()
    }
}

// MARK: - App Coordinator Navigations
extension AppCoordinator: MovieListNavigation, MovieDetailNavigaiton, TrailerNavigation {
    func goToMovieListPage() {
        let movieListViewModel = MovieListViewModel()
        movieListViewModel.navigation = self
        let movieListViewController = MovieListViewController(viewModel: movieListViewModel)
        navigationController.pushViewController(movieListViewController, animated: true)
    }
    
    func goToDetailPage(with viewModel: DetailMovieViewControllerViewModelProtocol) {
        var viewModel = viewModel
        viewModel.navigation = self
        let detailMovieViewController = DetailMovieViewController(viewModel: viewModel)
        navigationController.pushViewController(detailMovieViewController, animated: true)
    }
    
    func openYoutubeVideo(by url: URL) {
        let config = SFSafariViewController.Configuration()
        let safariViewController = SFSafariViewController(url: url, configuration: config)
        safariViewController.modalPresentationStyle = .fullScreen
        navigationController.present(safariViewController, animated: true, completion: nil)
    }
}
