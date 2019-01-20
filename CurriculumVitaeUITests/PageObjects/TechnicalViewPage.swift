//
//  TechnicalViewPage.swift
//  CurriculumVitaeUITests
//
//  Created by Suman Chatterjee on 20/01/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation
import Nimble
import XCTest

class TechnicalViewPage {
    var app: XCUIApplication?
    
    init(_ ourApp: XCUIApplication?) {
        app = ourApp
    }
    @discardableResult
    func expectOnPage(file: String = #file, line: UInt = #line) -> TechnicalViewPage {
        expect(self.app?.staticTexts["Technical Skills"].exists, file: file, line: line).toEventually(beTrue())
        return self
    }
}

