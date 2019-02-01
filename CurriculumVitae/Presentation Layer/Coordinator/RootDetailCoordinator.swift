//
//  RootDetailCoordinator.swift
//  CurriculumVitae
//
//  Created by Suman Chatterjee on 01/02/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation
import UIKit

enum Commitment {
    case technical(Technical)
    case experience([Result])
    case none
}

class RootDetailCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    private var currentCommitment: Commitment = .none
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
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
    
    func setCommitment(_ commitment: Commitment) {
        currentCommitment = commitment
    }
}

