//
//  RequestTest.swift
//  CurriculumVitaeTests
//
//  Created by Suman Chatterjee on 26/08/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Quick
import Nimble

@testable import CurriculumVitae

class RequestTest : QuickSpec {
    
    override func spec() {
        describe("Request test") {
            context("Request should return a valid URL") {
                it("Should return a valid URLRequest when it have a path and parameters") {
                    let path = "aPath"
                    let parameters = ["aParameters", "bparameters"]
                    let request = Request(Constant.baseURL!, path: path, parameters: parameters)
                    expect(request.urlRequest()).notTo(beNil())
                    
                    let method = request.urlRequest().httpMethod
                    expect(method).to(equal("GET"))
                    
                    let url = request.urlRequest().url?.absoluteString
                    expect(url).to(equal("http://localhost:8088/aPath/aParameters/bparameters"))
                }
                it("Should return a same url when its call URLRequest class") {
                    let url = URL(string: "https://www.common.com")
                    let request = URLRequest(url: url!)
                    expect(request.urlRequest().url?.absoluteString).to(equal("https://www.common.com"))
                    
                }
            }
        }
    }
}
