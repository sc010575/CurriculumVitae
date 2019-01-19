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
                    let (wnd, tearDown) = (viewController?.appearInWindowTearDown())!
                    defer { tearDown() }
                }

                afterEach {
                    self.server.stop()
                }
                it("has load the title is gists file loaded successfully") {
                    expect(viewController?.title).toEventually(equal("Suman Chatterjee"))
                    
                }
                it("should populate the profile view with right value") {
                    expect(viewController?.profileView.addressLabel.text).toEventually(equal("131 West Plaza, Townlane , Stanwell, Staines-Upon-Thames, TW19 7FH"))
                    expect(viewController?.profileView.emailLabel.text).toEventually(equal("chatterjeesuman@gmail.com"))
                    expect(viewController?.profileView.phoneLabel.text).toEventually(equal("+447856518020"))

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
