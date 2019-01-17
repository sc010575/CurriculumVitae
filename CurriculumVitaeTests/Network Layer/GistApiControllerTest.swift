//
//  GistApiControllerTest.swift
//  CurriculumVitaeTests
//
//  Created by Suman Chatterjee on 17/01/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Quick
import Nimble

@testable import CurriculumVitae

class GistApiControllerTest: QuickSpec {
    var server: MockServer!
    var apiController = GistApiController()
    override func spec() {
        beforeEach {
            self.server = MockServer()
        }

        afterEach {
            self.server.stop()
        }
        describe("GistApiController Test") {
            context("When gistFile api is called") {
                it("it returns a valid raw url when call is successful") {
                    self.server.respondToGists().start()
                    let downloadExpectiation = self.expectation(description: "Network service for gists main")

                    self.apiController.onSuccess { url in
                        expect(url).to(equal("https://gist.githubusercontent.com/sc010575/feb733f8c6d6c38b9db4208fb7791567/raw/75228d855b7c9069645ef8e1271aded319bc53c4/CurriculumVitae"))
                        downloadExpectiation.fulfill()
                    }.gistFile()
                    
                    self.waitForExpectations(timeout: 10) { (error) in
                        
                        if let error = error {
                            print("Error: \(error.localizedDescription)")
                        }
                    }
                }
            }
        }
    }
}
