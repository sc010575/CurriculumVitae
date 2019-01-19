//
//  RootViewModel.swift
//  CurriculumVitae
//
//  Created by Suman Chatterjee on 18/01/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation

class Box<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value

    }

    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}

class RootViewModel {

    private (set) var apiController: GistApiController!
    private (set) var curriculamVitae: Box<CurriculumVitae?> = Box(nil)
    init(_ apiController: GistApiController) {
        self.apiController = apiController
    }

    func getGists() {
        apiController.onSuccess { url in
            self.populateCV(url)
        }.gistFile()
    }

    func populateCV(_ url: String) {
        apiController.onRetriveCurriculumVitae { curriculamVitae in
            self.curriculamVitae.value = curriculamVitae
        }.populateCurriculumVitae(with: url)
    }

    func summary(for section: ElementsTitles) -> String {
        switch section {
        case .summary:
            return curriculamVitae.value?.profile ?? "Summary not found."
        case .technical:
            return curriculamVitae.value?.technicalKnowledge?.summary ?? ""
        case .experience:
            return ""
        }
    }
}
