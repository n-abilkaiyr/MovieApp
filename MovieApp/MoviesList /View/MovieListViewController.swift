//
//  ViewController.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 08.02.2022.
//

import UIKit

final class MovieListViewController: UITableViewController {
    private var listViewModel: MovieListViewModelProtocol!
    
    init(viewModel: MovieListViewModelProtocol) {
        self.listViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        listViewModel.fetchMovies { self.tableView.reloadData() }
    }
    
    private func configureViews() {
        title = Title.main
        view.backgroundColor = Color.backgroundColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(type: MovieTableViewCell.self)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
}

// MARK: - UITableViewDataSource
extension MovieListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listViewModel.numberOfRows
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withType: MovieTableViewCell.self, for: indexPath)
        let movieStatus = MovieStatus.getStatus(by: indexPath.row)
        let viewModel = listViewModel.cellViewModel(with: movieStatus)
        cell.configure(with: viewModel)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MovieListViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == MovieStatus.nowPlaying.position {
            return tableView.bounds.height * 0.45
        }
        return tableView.bounds.height * 0.3
    }
}

