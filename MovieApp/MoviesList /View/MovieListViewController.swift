//
//  ViewController.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 08.02.2022.
//

import UIKit

class MoviesListViewController: UITableViewController  {
    
   
    private var listViewModel: MovieListViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        listViewModel = MovieListViewModel()
        listViewModel.fetchMovies(by: .nowPlaying) {
            self.tableView.reloadRows(at: <#T##[IndexPath]#>, with: .automatic)
        }
    }
    
    
  private let viewModel = MoviesTableViewCellViewModel(
    collectionViewCellViewModels: [
    MoviesCollectionViewCellViewModel(name: "Apple", backgroundColor: .gray),
    MoviesCollectionViewCellViewModel(name: "Google", backgroundColor: .brown),
    MoviesCollectionViewCellViewModel(name: "Facebook", backgroundColor: .blue),
    MoviesCollectionViewCellViewModel(name: "Amazon", backgroundColor: .black),
    MoviesCollectionViewCellViewModel(name: "Netflix", backgroundColor: .red),
  ])
    
    private func configure() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 200
        tableView.register(MoviesTableViewCell.self, forCellReuseIdentifier: MoviesTableViewCell.identidier) 
        title = "Table View"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
    }
    
}

// MARK: - UITableViewDataSource
extension MoviesListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listViewModel.numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.identidier, for: indexPath) as! MoviesTableViewCell
        cell.configure(with: viewModel)
        
        return cell
    }
}
