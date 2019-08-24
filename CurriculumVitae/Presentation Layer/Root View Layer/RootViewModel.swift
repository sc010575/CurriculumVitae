//
//  RootViewModel.swift
//  CurriculumVitae
//
//  Created by Suman Chatterjee on 18/01/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation

protocol RootViewModelCoordinatorDelegate: class
{
    func RootViewModelDidSelectTechnicalData(_ viewModel: RootViewModel, data: Technical)
    func RootViewModelDidSelectExperienceData(_ viewModel: RootViewModel, data: [Resultdata])
}

protocol RootViewModelProtocol:class {

    var apiController: ApiController { get set}
    var curriculamVitae:Box<CurriculumVitae?> { get set }
    var coordinatorDelegate: RootViewModelCoordinatorDelegate? { get set}
    var applicationState: Box<State> { get set}
    
    func getGists()
    func summary(for section: ElementsTitles) -> String
    func useItemAtIndex(_ section: ElementsTitles, _ index: Int)
}

class RootViewModel:RootViewModelProtocol {
    var apiController: ApiController
    var curriculamVitae: Box<CurriculumVitae?> = Box(nil)
    var applicationState: Box<State> = Box(State.notFetchededYet)
    
    weak var coordinatorDelegate: RootViewModelCoordinatorDelegate?

    init(_ apiController:ApiController) {
        self.apiController = apiController
    }

    func getGists() {
        apiController.onSuccess { url in
            self.populateCV(url)
        }.onFailure { status, error in
            self.applicationState.value = status
        }.gistFile()
    }

    func populateCV(_ url: String) {
        apiController.onRetriveCurriculumVitae { curriculamVitae in
            self.curriculamVitae.value = curriculamVitae
        }.onFailure { state, _ in
            self.applicationState.value = state
        }.populateCurriculumVitae(with: url)
    }

    func summary(for section: ElementsTitles) -> String {
        switch section {
        case .summary:
            return curriculamVitae.value?.profile ?? "Summary not found."
        case .technical:
            return curriculamVitae.value?.technicalKnowledge?.summary ?? ""
        case .experience:
            guard let objective = curriculamVitae.value?.results[0].overview else {
                return ""
            }
            return objective
        default:
            return ""
        }
    }

    func useItemAtIndex(_ section: ElementsTitles, _ index: Int)
    {
        switch section {
        case .technical:
            if let coordinatorDelegate = coordinatorDelegate, let technical = curriculamVitae.value?.technicalKnowledge {
                coordinatorDelegate.RootViewModelDidSelectTechnicalData(self, data: technical)
            }
        case .experience:
            if let coordinatorDelegate = coordinatorDelegate,
                let results = curriculamVitae.value?.results {
                coordinatorDelegate.RootViewModelDidSelectExperienceData(self, data: results)
            }
        default:
            break
        }

    }

}
