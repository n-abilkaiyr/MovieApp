//
//  ViewController.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 08.02.2022.
//

import UIKit

class MovieListViewController: UITableViewController  {
    private var listViewModel: MovieListViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        
        listViewModel = MovieListViewModel()
        listViewModel.fetchMovies() { self.tableView.reloadData() }
    }
    
 
    
    private func configureViews() {
        view.backgroundColor = .systemBackground
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 200
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        tableView.separatorStyle = .none
        
        title = "Фильмы"
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
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        
        let movieStatus = MovieStatus.getStatus(by: indexPath.row)
        cell.cellViewModel = listViewModel.cellViewModel(with: movieStatus)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MovieListViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == MovieStatus.nowPlaying.position {
            return tableView.bounds.height * 0.45
        }
        return tableView.bounds.height * 0.25
    }
}
