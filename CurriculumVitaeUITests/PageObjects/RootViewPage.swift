//
//  RootViewPage.swift
//  CurriculumVitaeUITests
//
//  Created by Suman Chatterjee on 20/01/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation
import Nimble
import XCTest

class RootViewPage {
    var app: XCUIApplication?
    
    init(_ ourApp: XCUIApplication?) {
        app = ourApp
    }
    @discardableResult
    func expectOnPage(file: String = #file, line: UInt = #line) -> RootViewPage {
        expect(self.app?.otherElements["PROFILE"].exists, file: file, line: line).toEventually(beTrue())
        return self
    }
    
    @discardableResult
    func expectProfileName(file: String = #file, line: UInt = #line) -> RootViewPage {
        expect(self.app?.otherElements["Suman Chatterjee"].exists, file: file, line: line).toEventually(beTrue())
        return self
    }
}

