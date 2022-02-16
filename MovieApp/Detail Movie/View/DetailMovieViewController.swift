//
//  DetailMovieViewController.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 14.02.2022.
//

import UIKit
protocol DetailMovieViewControllerViewModelProtocol {
    var rating: String { get }
    func fetchMovie(completion: @escaping () -> Void)
}

class DetailMovieViewController: UIViewController {
    
    private var viewModel: DetailMovieViewControllerViewModelProtocol
   
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBlue
        return scrollView
    }()
    
    init(viewModel: DetailMovieViewControllerViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var mainVStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fill
        sv.alignment = .fill
        sv.spacing = 10
        return sv
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
    
        scrollView.addSubview(mainVStackView)
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        mainVStackView.translatesAutoresizingMaskIntoConstraints = false
        
        viewModel.fetchMovie {
            print(self.viewModel.rating)
            self.title = self.viewModel.rating
            print("testing")
        }
        
    }
}
