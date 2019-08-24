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

class ApplicationCoordinator: Coordinator, ConnectivityListener {
    
    func ConnectivityStatusDidChanged() {
        rootViewCoordinator.checkConnectivity()
    }
    
    private let window: UIWindow
    private let navigationController: UINavigationController
    private let rootViewCoordinator: RootViewCoordinator
    private let connectivityHandler: ConnectivityHandler

    init(window: UIWindow, connectivityHandler:ConnectivityHandler = ConnectivityHandler()) {
        self.window = window
        navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        rootViewCoordinator = RootViewCoordinator(presenter: navigationController)
        self.connectivityHandler = connectivityHandler
        self.connectivityHandler.addListener(listener: self)
    }
    func start() {
        window.rootViewController = navigationController
        connectivityHandler.startNotifier()
        rootViewCoordinator.start()
        window.makeKeyAndVisible()
    }
    
}
