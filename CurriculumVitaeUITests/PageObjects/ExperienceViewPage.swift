//
//  ExperienceViewPage.swift
//  CurriculumVitaeUITests
//
//  Created by Suman Chatterjee on 20/01/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation
import Nimble
import XCTest

class ExperienceViewPage {
    var app: XCUIApplication?
    
    init(_ ourApp: XCUIApplication?) {
        app = ourApp
    }
    @discardableResult
    func expectOnPage(file: String = #file, line: UInt = #line) -> ExperienceViewPage {
        expect(self.app?.staticTexts["Experience"].exists, file: file, line: line).toEventually(beTrue())
        return self
    }
    
    @discardableResult
    func tapExperience(file: String = #file, line: UInt = #line) -> ExperienceViewPage {
        expect(self.app?.tables.staticTexts["Sainsbury's"].exists, file: file, line: line).toEventually(beTrue())
        app?.tables.staticTexts["Sainsbury's"].tap()
        return self
    }
}
