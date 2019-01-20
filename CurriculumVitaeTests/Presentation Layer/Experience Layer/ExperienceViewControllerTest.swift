//
//  ExperienceViewControllerTest.swift
//  CurriculumVitaeTests
//
//  Created by Suman Chatterjee on 20/01/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Nimble
import Quick
@testable import CurriculumVitae

final class ExperienceViewControllerTest: QuickSpec {

    override func spec() {
        describe("ExperienceViewController tests") {
            var viewController: ExperienceViewController?
            let storyboard = UIStoryboard(name: "Experience", bundle: nil)
            beforeEach {
                viewController = storyboard.instantiateViewController(withIdentifier: "ExperienceViewController") as? ExperienceViewController
            }
            context("When ExperienceViewController is launched ") {
                beforeEach {
                    let result1 = Result(company: "Company 1", icon: "A Icon", startDate: "01-02-2001", endDate: "", overview: "A goo job", title: "Engineer", jobType: "Contract", responsibility: ["One", "Two"])

                    let result2 = Result(company: "Company 2", icon: "A new Icon", startDate: "01-02-2000", endDate: "31-12-2000", overview: "A goo job", title: "Developer", jobType: "Permanent", responsibility: ["One", "Two", "Three"])

                    let technicals = [result1, result2]
                    viewController?.viewModel = ExperienceViewModel(technicals)
                    viewController?.preloadView()
                    let (wnd, tearDown) = (viewController?.appearInWindowTearDown())!
                    defer { tearDown() }

                }

                it("has load the right number of experiences") {
                    expect(viewController?.viewModel.experiences.value.count).toEventually(equal(2))
                }
                it("should display right experience icon") {
                    expect(viewController?.viewModel.experiences.value[0].icon).toEventually(equal("A Icon"))
                }

                it("should return the right number of rows") {

                    expect(viewController?.tableView.numberOfRows(inSection: 0)).to(equal(2))
                }
                it("should populate the experience tableview cell properly") {

                    let cell = viewController?.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? ExperienceListTableViewCell
                    expect(cell?.titleLabel.text).to(equal("Company 1"))
                    expect(cell?.dateLabel.text).to(equal("Jan 20,2019 - Till Date"))
                    expect(cell?.overviewLabel.text).to(equal("A goo job"))

                }
            }
        }
    }
}
