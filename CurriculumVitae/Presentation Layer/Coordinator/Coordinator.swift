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
    private let window: UIWindow
    private let navigationController: UINavigationController
    private let rootViewCoordinator: Coordinator

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
