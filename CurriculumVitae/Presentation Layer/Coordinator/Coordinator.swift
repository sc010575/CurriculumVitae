//
//  Coordinator.swift
//  CurriculumVitae
//
//  Created by Suman Chatterjee on 18/01/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator {
    func start()
}

class ApplicationCoordinator: Coordinator {
    let window: UIWindow
    let navigationController: UINavigationController
    let rootViewCoordinator: RootViewCoordinator

    init(window: UIWindow) {
        self.window = window
        navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        rootViewCoordinator = RootViewCoordinator(presenter: navigationController)
    }
    func start() {
        window.rootViewController = navigationController
        rootViewCoordinator.start()
        window.makeKeyAndVisible()
    }
}

class RootViewCoordinator: Coordinator {
    private let presenter: UINavigationController
    private var rootViewController: RootViewController?
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }

    func start() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let rootViewController = storyBoard.instantiateViewController(withIdentifier: "RootViewController") as? RootViewController else { return }
        rootViewController.title = "Loading..."
        let apiController = GistApiController()
        let viewModel = RootViewModel(apiController)
        rootViewController.viewModel = viewModel
        presenter.pushViewController(rootViewController, animated: true)
        self.rootViewController = rootViewController
    }
}
