//
//  GistApiController.swift
//  CurriculumVitae
//
//  Created by Suman Chatterjee on 17/01/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation

protocol ApiController {
    func onSuccess(_ handler: @escaping (_ url: String) -> Void) -> ApiController
    func onFailure(_ handler: @escaping (_ result: State, _ error: Error?) -> Void) -> ApiController
    func onRetriveCurriculumVitae(_ handler: @escaping (_ curriculumVitae: CurriculumVitae) -> Void) -> ApiController

    func gistFile()
    func populateCurriculumVitae(with url: String)
}

enum State {
    case notFetchededYet
    case loading
    case noResults
    case dataError
    case success
}


class GistApiController: NSObject, ApiController {

    private(set) var onSuccess: ((_ url: String) -> Void)?
    private(set) var onFailure: ((_ result: State, _ error: Error?) -> Void)?
    private(set) var onRetriveCurriculumVitae: ((_ curriculumVitae: CurriculumVitae) -> Void)?
    private(set) var state: State = .notFetchededYet

    @discardableResult
    func onSuccess(_ handler: @escaping (_ url: String) -> Void) -> ApiController {
        self.onSuccess = handler

        return self
    }

    @discardableResult
    func onFailure(_ handler: @escaping (_ result: State, _ error: Error?) -> Void) -> ApiController {
        self.onFailure = handler

        return self
    }

    @discardableResult
    func onRetriveCurriculumVitae(_ handler: @escaping (_ curriculumVitae: CurriculumVitae) -> Void) -> ApiController {
        self.onRetriveCurriculumVitae = handler

        return self
    }

    func gistFile() {

        let urlRequest = Request(path: Constant.QueryType.gists.rawValue, parameters: [Constant.fileId])
        Network.shared.send(urlRequest) { (result: Result<GistMain, Error>) in
            switch result {
            case .success(let gistMain):
                let s = gistMain.files["CurriculumVitae"]
                self.onSuccess?(s?.rawUrl ?? "")
            case .failure(let error):
                self.onFailure?(.dataError, error)
            }
        }
    }

    func populateCurriculumVitae(with url: String) {
        guard let cvURL = URL(string: url) else { return }
        let urlRequest = URLRequest(url: cvURL)
        Network.shared.send(urlRequest) { (result: Result<CurriculumVitae, Error>) in
            switch result {
            case .success(let cv):
                self.onRetriveCurriculumVitae?(cv)
            case .failure(let error):
                self.onFailure?(.dataError, error)
            }
        }
    }
}
