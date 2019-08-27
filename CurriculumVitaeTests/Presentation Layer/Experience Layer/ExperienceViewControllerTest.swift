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
            context("When ExperienceViewController is launched ") {
                beforeEach {
                    viewController = storyboard.instantiateViewController(withIdentifier: "ExperienceViewController") as? ExperienceViewController
                    let result1 = Resultdata(company: "Company 1", icon: "A Icon", startDate: "2018-10-03", endDate: "", overview: "A good job", title: "Engineer", jobType: "Contract", responsibility: ["One", "Two"])

                    let result2 = Resultdata(company: "Company 2", icon: "A new Icon", startDate: "2016-10-03", endDate: "2018-09-03", overview: "A good job", title: "Developer", jobType: "Permanent", responsibility: ["One", "Two", "Three"])

                    let technicals = [result1, result2]
                    viewController?.viewModel = ExperienceViewModel(technicals)
                  //  viewController?.preloadView()
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
                    expect(cell?.dateLabel.text).to(equal("Oct 03,2018 - Till Date"))
                    expect(cell?.overviewLabel.text).to(equal("A good job"))

                }
            }
        }
    }
}
