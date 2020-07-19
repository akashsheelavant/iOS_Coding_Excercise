//
//  FactsCoordinator.swift
//  iOS_Coding
//
//  Created by Akash Sheelavant - Vendor on 7/19/20.
//  Copyright © 2020 Akash Sheelavant. All rights reserved.
//

import UIKit

class FactsCoordinator {

    private let viewController: FactsViewController
    private let navigationController: UINavigationController

    init() {
        viewController = FactsViewController()
        let viewModel = FactsViewModel(networkManager: NetworkManager())
        viewController.viewModel = viewModel

        navigationController = UINavigationController(rootViewController: viewController)
    }

    func rootViewController() -> UIViewController {
        return navigationController
    }
}
