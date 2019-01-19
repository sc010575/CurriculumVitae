//
//  TechnicalViewControllerTest.swift
//  CurriculumVitaeTests
//
//  Created by Suman Chatterjee on 19/01/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Nimble
import Quick
@testable import CurriculumVitae

final class TechnicalViewControllerTest: QuickSpec {

    var server = MockServer()

    override func spec() {
        describe("TechnicalViewController tests") {
            var viewController: TechnicalViewController?
            let storyboard = UIStoryboard(name: "Technical", bundle: nil)
            beforeEach {
                viewController = storyboard.instantiateViewController(withIdentifier: "TechnicalViewController") as? TechnicalViewController
            }
            context("When TechnicalViewController is launched ") {
                beforeEach {
                    let technical = Technical(summary: "A summary", strong: ["Skill 1", "Skill 2"], developmentTools: "A Development tool", configurationManagement: "A configuration", programmingLanguage: "C++")

                    viewController?.viewModel = TechnicalViewModel(technical)
                    viewController?.preloadView()
                    let (wnd, tearDown) = (viewController?.appearInWindowTearDown())!
                    defer { tearDown() }

                }

                afterEach {
                    self.server.stop()
                }
                it("has load the right technical summary") {
                    expect(viewController?.viewModel.technical.value.summary).toEventually(equal("A summary"))
                }
                it("should load right strong skill sets") {
                    expect(viewController?.viewModel.technical.value.strong.count).toEventually(equal(2))
                    expect(viewController?.viewModel.technical.value.strong[0]).toEventually(equal("Skill 1"))
                }
                it("should load right value for other technical summary"){
                    expect(viewController?.viewModel.technical.value.developmentTools).toEventually(equal("A Development tool"))
                    expect(viewController?.viewModel.technical.value.configurationManagement).toEventually(equal("A configuration"))
                    expect(viewController?.viewModel.technical.value.programmingLanguage).toEventually(equal("C++"))

                }
                it("should load right number of section") {
                    expect(viewController?.tableView.numberOfSections).toEventually(equal(2))
                }
            }
        }
    }
}
