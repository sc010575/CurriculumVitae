//
//  RootViewCoordinator.swift
//  CurriculumVitae
//
//  Created by Suman Chatterjee on 01/02/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation
import UIKit

enum Commitment {
    case technical(Technical)
    case experience([Resultdata])
    case none
}


class RootViewCoordinator: Coordinator {
    private let presenter: UINavigationController
    private (set) var rootViewController: RootViewController?
    private (set) var viewModel: RootViewModel?
 
    private let connectivityHandler: ConnectivityHandler
    private var currentCommitment: Commitment {
        didSet {
            applyCurrentCommintment()
        }
    }
    weak var delegate: RootViewModelCoordinatorDelegate?

    init(presenter: UINavigationController, connectivityHandler: ConnectivityHandler = ConnectivityHandler()) {
        self.presenter = presenter
        self.currentCommitment = .none
        self.connectivityHandler = connectivityHandler
        self.connectivityHandler.addListener(listener: self)
        self.connectivityHandler.startNotifier()
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
}

extension RootViewCoordinator: RootViewModelCoordinatorDelegate
{
    func RootViewModelDidSelectExperienceData(_ viewModel: RootViewModel, data: [Resultdata]) {
        currentCommitment = Commitment.experience(data)
    }

    func RootViewModelDidSelectTechnicalData(_ viewModel: RootViewModel, data: Technical) {
        currentCommitment = Commitment.technical(data)
    }
}

extension RootViewCoordinator : ConnectivityListener {
    func ConnectivityStatusDidChanged(_ connectionChangeEvent: ConnectionChangeEvent) {
        if connectionChangeEvent == .reEstablished {
            viewModel?.getGists()
        }
    }
}

private extension RootViewCoordinator {
    func applyCurrentCommintment () {
        //Start
        switch currentCommitment {
        case .technical(let technical):
            let storyboard = UIStoryboard(name: "Technical", bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: "TechnicalViewController") as? TechnicalViewController {
                let techViewModel = TechnicalViewModel(technical)
                vc.viewModel = techViewModel
                presenter.pushViewController(vc, animated: true)
            }
        case .experience(let results):
            let storyboard = UIStoryboard(name: "Experience", bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: "ExperienceViewController") as? ExperienceViewController {
                let viewModel = ExperienceViewModel(results)
                vc.viewModel = viewModel
                presenter.pushViewController(vc, animated: true)
            }
        default:
            break
        }
    }
}
