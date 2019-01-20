//
//  CurriculumVitaeTest.swift
//  CurriculumVitaeTests
//
//  Created by Suman Chatterjee on 20/01/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Quick
import Nimble

@testable import CurriculumVitae

class CurriculumVitaeTest: QuickSpec {
    override func spec() {
        describe("CurriculumVitae Test") {
            context("when valid data for CurriculumVitae model") {
                it("should parse and load the model properly") {
                    let dataResult = Fixtures.getJSONData(jsonPath: "curriculumvitae")
                    if let cv: CurriculumVitae = ParseJson.parse(data: dataResult!) {
                        expect(cv.address).to(equal("131 West Plaza, Townlane , Stanwell, Staines-Upon-Thames, TW19 7FH"))
                        expect(cv.email).to(equal("chatterjeesuman@gmail.com"))
                        expect(cv.phone).to(equal("+447856518020"))
                        expect(cv.name).to(equal("Suman Chatterjee"))
                        expect(cv.results.count).to(equal(3))
                    }

                }
            }
            context("when an invalid data for CurriculumVitae model") {
                it("should not parse and send nil") {
                    let dataResult = Fixtures.getJSONData(jsonPath: "empty")
                    let cv:CurriculumVitae? = ParseJson.parse(data: dataResult!)
                    expect(cv).to(beNil())
                }
            }
        }
    }
}
