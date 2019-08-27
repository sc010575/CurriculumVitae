//
//  ExperienceDetailsViewControllerTest.swift
//  CurriculumVitaeTests
//
//  Created by Suman Chatterjee on 20/01/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Nimble
import Quick
@testable import CurriculumVitae

final class ExperienceDetailsViewControllerTest: QuickSpec {

    override func spec() {
        describe("ExperienceDetailsViewControllerTest tests") {
            var viewController: ExperienceDetailsViewController?
            let storyboard = UIStoryboard(name: "Experience", bundle: nil)
            context("When ExperienceDetailsViewController is launched ") {
                beforeEach {
                    viewController = storyboard.instantiateViewController(withIdentifier: "ExperienceDetailsViewController") as? ExperienceDetailsViewController
                    let result = Resultdata(company: "Company 1", icon: "A Icon", startDate: "01-02-2001", endDate: "", overview: "A goo job", title: "Engineer", jobType: "Contract", responsibility: ["One", "Two"])

                    viewController?.experience = result
                    viewController?.preloadView()
                    let (wnd, tearDown) = (viewController?.appearInWindowTearDown())!
                    defer { tearDown() }

                }

                it("has should load right responsibilities") {
                    expect(viewController?.companyLabel.text).to(equal("Company 1"))
                    expect(viewController?.jobTitleLabel.text).to(equal("Engineer"))
                    expect(viewController?.responseLabel.text).to(equal("• One\n\n• Two\n\n"))

                }
            }
        }
    }
}
