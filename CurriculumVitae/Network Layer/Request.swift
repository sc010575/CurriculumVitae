//
//  Request.swift
//  CurriculumVitae
//
//  Created by Suman Chatterjee on 26/08/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation

protocol Requestable {
    func urlRequest() -> URLRequest
}

extension URLRequest: Requestable {
    func urlRequest() -> URLRequest { return self }
}

struct Request: Requestable {
    let baseUrl:URL
    let path: String
    let parameters:[String]?
    let method: String
    
    init(_ baseURL:URL, path: String, parameters:[String]? = [], method: String = "GET") {
        self.baseUrl = baseURL
        self.path = path
        self.method = method
        self.parameters = parameters
    }
    
    func urlRequest() -> URLRequest {
        var finalUrl = baseUrl.appendingPathComponent(path)
        self.parameters?.forEach{ finalUrl = finalUrl.appendingPathComponent($0)}
        
        var urlRequest = URLRequest(url: finalUrl)
        urlRequest.httpMethod = method
        
        return urlRequest
    }
}

