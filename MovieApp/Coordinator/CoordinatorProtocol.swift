//
//  CoordinatorProtocol.swift
//  MovieApp
//
//  Created by Abilkaiyr Nurzhan on 07.03.2022.
//

import UIKit

protocol Coordinator {
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
