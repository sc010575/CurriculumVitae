//
//  NetworkHandler.swift
//  CurriculumVitae
//
//  Created by Suman Chatterjee on 24/08/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation
protocol NetworkUseCase {
    func send<T: Model>(_ request: Requestable, completion: @escaping (Result<T, Error>) -> Void)
    
}

protocol Model: Codable { }

class Network: NetworkUseCase {
    static let shared = Network()
    let session: URLSession = URLSession(configuration: .default)

    private init() { }

    enum NetworkError: Error {
        case noDataOrError
        case jsonDecodingError
    }

    struct StatusCodeError: LocalizedError {
        let code: Int

        var errorDescription: String? {
            return "An error occurred communicating with the server. Please try again."
        }
    }

    func send<T: Model>(_ request: Requestable, completion: @escaping (Result<T, Error>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let urlRequest = request.urlRequest()
            let task = self.session.dataTask(with: urlRequest) { data, response, error in
                let result: Result<T, Error>
                if let error = error {
                    result = .failure(error)
                } else if let error = self.error(from: response) {
                    result = .failure(error)
                } else if let data = data {
                    if let model: T = ParseJson.parse(data: data) {
                        result = .success(model)
                    } else {
                        result = .failure(NetworkError.jsonDecodingError)
                    }
                } else {
                    Log.assertFailure("Missing both data and error from NSURLSession. This should never happen.")
                    result = .failure(NetworkError.noDataOrError)
                }

                DispatchQueue.main.async {
                    completion(result)
                }
            }
            task.resume()
        }
    }

    private func error(from response: URLResponse?) -> Error? {
        guard let response = response as? HTTPURLResponse else {
            Log.assertFailure("Missing http response when trying to parse a status code.")
            return nil
        }

        let statusCode = response.statusCode

        if statusCode >= 200 && statusCode <= 299 {
            return nil
        } else {
            Log.error("Invalid status code from \(response.url?.absoluteString ?? "unknown"): \(statusCode)")
            return StatusCodeError(code: statusCode)
        }
    }
}
