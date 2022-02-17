//
//  DetailMovieViewController.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 14.02.2022.
//

import UIKit

final class DetailMovieViewController: UIViewController {
    
    private var viewModel: DetailMovieViewControllerViewModelProtocol
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBlue
        return scrollView
    }()
    
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private lazy var movieInfoStackView: MoviewInfoView = {
        let sv = MoviewInfoView()
        sv.setup()
        return sv
    }()
   
    private lazy var seperatorView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 110, height: 200))
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var mainStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [imageView, movieInfoStackView,seperatorView])
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .fill
        sv.spacing = 8
       
        return sv
    }()
    

    
    init(viewModel: DetailMovieViewControllerViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    override func viewDidLoad() {
        configureViews()
        
        viewModel.fetchMovie {
            self.updateUI()
            self.viewModel.fetchImageData { data in
                self.imageView.image = UIImage(data: data)
            }
        }
    }
    
    private func updateUI() {
        movieInfoStackView.updateUI(with: viewModel.genreText,
                                          viewModel.yearText,
                                          viewModel.durationText,
                                          viewModel.overViewText,
                                          viewModel.ratingText,
                                          viewModel.scoreText)
    }
    
    private func configureViews() {
        view.backgroundColor = .systemBackground
        mainStackView.backgroundColor = .cyan
        
        scrollView.addSubview(mainStackView)
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
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
            imageView.heightAnchor.constraint(equalToConstant: 200),
        ])
        
    }
}
