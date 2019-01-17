//
//  GistApiController.swift
//  CurriculumVitae
//
//  Created by Suman Chatterjee on 17/01/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation

enum State {
    case notFetchededYet
    case loading
    case noResults
    case dataError
    case success
}


class GistApiController: NSObject {

    private(set) var onSuccess: ((_ url: String) -> Void)?
    private(set) var onFailure: ((_ result: State, _ error: Error?) -> Void)?
    private(set) var state: State = .notFetchededYet

    @discardableResult
    func onSuccess(_ handler: @escaping (_ url: String) -> Void) -> GistApiController {
        self.onSuccess = handler

        return self
    }

    @discardableResult
    func onFailure(_ handler: @escaping (_ result: State, _ error: Error?) -> Void) -> GistApiController {
        self.onFailure = handler

        return self
    }

    func gistFile() {
        guard let baseUrl = Constant.baseURL else { return }
        let url = baseUrl.appendingPathComponent(Constant.fileId)
        let urlRequest = URLRequest(url: url)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        state = .loading
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            if error != nil, let error = error {
                self.onFailure?(.noResults, error)
            } else {
                if let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200, let data = data {
                    if let gistMain: GistMain = ParseJson.parse(data: data) {
                        let s = gistMain.files["CurriculumVitae"]
                        self.onSuccess?(s?.rawUrl ?? "")
                    }

                }
            }
            DispatchQueue.main.async {
                self.state = .dataError
                self.onFailure?(.dataError, nil)
            }
        })
        task.resume()
    }

    func populateCurriculumVitae(with url: String) {
        guard let url = URL(string: url) else {
            return
        }
        let urlRequest = URLRequest(url: url)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)

        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in

            if error != nil, let error = error {
                self.onFailure?(.noResults, error)

            } else {
                guard let data = data else { return }

                if let curriculumVitae: CurriculumVitae = ParseJson.parse(data: data) {
                    print(curriculumVitae.name)
                    print(curriculumVitae.profileImage)
                    print(curriculumVitae.results[0].company)
                }
            }

        })
        task.resume()
    }
}
