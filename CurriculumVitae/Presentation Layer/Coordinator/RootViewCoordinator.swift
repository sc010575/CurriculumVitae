//
//  RootViewCoordinator.swift
//  CurriculumVitae
//
//  Created by Suman Chatterjee on 01/02/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation
import UIKit

class RootViewCoordinator: Coordinator {
    private let presenter: UINavigationController
    private var rootViewController: RootViewController?
    
    weak var delegate: RootViewModelCoordinatorDelegate?
    private var rootDetailCoordinator: RootDetailCoordinator?
    private var viewModel:RootViewModel?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        rootDetailCoordinator = RootDetailCoordinator(presenter: presenter)
    }
    
    func start() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let rootViewController = storyBoard.instantiateViewController(withIdentifier: "RootViewController") as? RootViewController else { return }
        rootViewController.title = "Loading..."
        let apiController = GistApiController()
        viewModel = RootViewModel(apiController)
        viewModel?.coordinatorDelegate = self
        rootViewController.viewModel = viewModel
        presenter.pushViewController(rootViewController, animated: true)
        self.rootViewController = rootViewController
    }
    
    func checkConnectivity() {
        viewModel?.getGists()
    }
}

extension RootViewCoordinator: RootViewModelCoordinatorDelegate
{
    func RootViewModelDidSelectExperienceData(_ viewModel: RootViewModel, data: [Resultdata]) {
        let commitment = Commitment.experience(data)
        rootDetailCoordinator?.setCommitment(commitment)
        rootDetailCoordinator?.start()
    }
    
    func RootViewModelDidSelectTechnicalData(_ viewModel: RootViewModel, data: Technical) {
        let commitment = Commitment.technical(data)
        rootDetailCoordinator?.setCommitment(commitment)
        rootDetailCoordinator?.start()
    }
}
