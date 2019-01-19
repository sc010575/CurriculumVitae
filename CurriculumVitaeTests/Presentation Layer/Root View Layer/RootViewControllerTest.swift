//
//  RootViewControllerTest.swift
//  CurriculumVitaeTests
//
//  Created by Suman Chatterjee on 18/01/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Nimble
import Quick
@testable import CurriculumVitae

final class RootViewControllerTest: QuickSpec {

    var server = MockServer()

    override func spec() {
        describe("RootViewController tests") {
            var viewController: RootViewController?
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            beforeEach {
                viewController = storyboard.instantiateViewController(withIdentifier: "RootViewController") as? RootViewController
                viewController?.title = "Loading .."
            }
            context("When RootViewController is launched ") {
                beforeEach {
                    self.server.respondToGists().respondToGistFile().start()
                    viewController?.viewModel = RootViewModel(GistApiController())
                    viewController?.preloadView()
                }

                afterEach {
                    self.server.stop()
                }
                it("has load the title is gists file loaded successfully") {
                    let (wnd, tearDown) = (viewController?.appearInWindowTearDown())!
                    defer { tearDown() }

                    expect(viewController?.title).toEventually(equal("Suman Chatterjee"))

                }
                it("should load right number of section") {
                    let (wnd, tearDown) = (viewController?.appearInWindowTearDown())!
                    defer { tearDown() }
                    expect(viewController?.tableView.numberOfSections).toEventually(equal(2))
                }
            }
        }
    }
}
