//
//  RootViewTest.swift
//  CurriculumVitaeUITests
//
//  Created by Suman Chatterjee on 20/01/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Nimble
import Quick

extension XCUIApplication {
    func setUITestLocalServer() -> XCUIApplication {
        launchEnvironment["IsLocalServerBackend"] = "true"
        return self
    }
}

class RootViewTest: QuickSpec {
    override func spec() {
        describe("RootView Test") {
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
            context("When the user navigates to the app and then to the launch screen") {
                it("displays the root view page") {
                    app?.launch()

                    _ = RootViewPage(app)
                        .expectOnPage()
                }
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
                        .expectProfileName()
                }
                it("should display Technical Knowledge page when tap technical knowledge") {
                    _ = RootViewPage(app)
                        .expectOnPage()
                        .tapTechnical()

                    _ = TechnicalViewPage(app)
                        .expectOnPage()
                }
            }
            context("when CurriculumVitae is fetched from the git hub") {
                beforeEach {
                    server?.respondToGists().respondToGistFileWithError()
                    server?.start()
                    app?.launch()

                }
                it("should display profile detailes after successful call") {

                    _ = RootViewPage(app)
                        .expectDataErrorDialogue()
                }
            }
        }
    }
}
