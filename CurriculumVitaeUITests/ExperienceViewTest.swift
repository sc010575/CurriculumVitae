//
//  ExperienceViewTest.swift
//  CurriculumVitaeUITests
//
//  Created by Suman Chatterjee on 20/01/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Nimble
import Quick


class ExperienceViewTest: QuickSpec {
    override func spec() {
        describe("ExperienceView Test") {
            var app: XCUIApplication?
            var server: MockServer?
            
            beforeEach {
                self.continueAfterFailure = false
                Nimble.AsyncDefaults.Timeout = 15
                
                server = MockServer()
                
                app = XCUIApplication()
                    .setUITestLocalServer()
            }
            afterEach {
                app?.terminate()
                server?.stop()
            }
            context("when CurriculumVitae is fetched from the git hub") {
                beforeEach {
                    server?.respondToGists().respondToGistFile()
                    server?.start()
                    app?.launch()
                    
                }
                it("should display profile detailes after successful call") {
                    
                    _ = RootViewPage(app)
                        .expectOnPage()
                        .tapExperience()
                    
                    _ = ExperienceViewPage(app)
                        .expectOnPage()
                }
                it("should display responsibilities if user tap the experiences") {
                    _ = RootViewPage(app)
                        .expectOnPage()
                        .tapExperience()
                    
                    _ = ExperienceViewPage(app)
                        .expectOnPage()
                        .tapExperience()
                    
                    _ = ExperienceDetailsPage(app)
                        .expectOnPage()
                }
            }
        }
    }
}
