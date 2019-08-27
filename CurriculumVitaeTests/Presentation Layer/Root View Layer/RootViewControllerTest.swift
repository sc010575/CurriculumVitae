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

final class SegueHelper {

    static func segues(ofViewController viewController: UIViewController) -> [String] {
        let identifiers = (viewController.value(forKey: "storyboardSegueTemplates") as? [AnyObject])?.compactMap({ $0.value(forKey: "identifier") as? String }) ?? []
        return identifiers
    }
}


final class RootViewControllerTest: QuickSpec {

    var server = MockServer()

    override func spec() {
        describe("RootViewController tests") {
            var viewController: RootViewController?
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            context("When RootViewController is launched ") {
                beforeEach {
                    viewController = storyboard.instantiateViewController(withIdentifier: "RootViewController") as? RootViewController
                    viewController?.title = "Loading .."
                    self.server.respondToGists().respondToGistFile().start()
                    viewController?.viewModel = RootViewModel(GistApiController())
                    viewController?.preloadView()
                    let (_, tearDown) = (viewController?.appearInWindowTearDown())!
                    do { tearDown() }
                }

                afterEach {
                    self.server.stop()
                }
                it("has load the title is gists file loaded successfully") {
                    expect(viewController?.title).toEventually(equal("Suman Chatterjee"))

                }
                it("should have shadow opacity is zero initially") {
                    expect(viewController?.profileView.layer.shadowOpacity).toEventually(equal(0))

                }
                it("should populate the profile view with right value") {
                    expect(viewController?.profileView.addressLabel.text).toEventually(equal("131 West Plaza, Townlane , Stanwell, Staines-Upon-Thames, TW19 7FH"))
                    expect(viewController?.profileView.emailLabel.text).toEventually(equal("chatterjeesuman@gmail.com"))
                    expect(viewController?.profileView.phoneLabel.text).toEventually(equal("+447856518020"))

                }
                it("should load right number of section") {
                    expect(viewController?.rootTableView.numberOfSections).toEventually(equal(2))
                }
                it("should populate the professional summary") {
                    let cell = viewController?.rootTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? SummaryTableViewCell
                    if ((viewController?.viewModel.curriculamVitae.value?.profile) != nil) {
                        expect(cell?.summaryLabel.text).toEventually(equal("Senior iOS Developer more than 19 years of software development experience. Skills included strong knowledge of iOS, Objective-C, Swift, C/C++, Agile development approach, Object-Oriented Analysis and Design, Object Oriented Programming, software integration and Product development."))
                    }else{
                        expect(cell?.summaryLabel.text).toEventually(equal("Summary not found."))

                    }
                }
//                it("should perform right segue when technical knowledge is selected") {
//                    let indexPath = IndexPath(row: 0, section: 1)
//                    viewController?.tableView((viewController?.rootTableView!)!, didSelectRowAt: indexPath)
//                    if let technical = viewController?.viewModel.curriculamVitae.value?.technicalKnowledge{
//                        expect(technical.configurationManagement).toEventually(equal(""))
//                    }
//
//                    let segue = SegueHelper.segues(ofViewController: viewController!)
//                    expect(segue.contains("MoveToTechnical")).toEventually(beTrue())
//                    expect(segue.count).to(equal(2))
//
//                    let sender = viewController?.shouldPerformSegue(withIdentifier: "MoveToTechnical", sender: nil)
//                    expect(sender).toEventually(beTrue())
//                }
            }
        }
    }
}
