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
