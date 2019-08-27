//
//  RootViewModelCoordinatorTest.swift
//  CurriculumVitaeTests
//
//  Created by Suman Chatterjee on 27/08/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Nimble
import Quick
@testable import CurriculumVitae

final class RootViewModelCoordinatorTest: QuickSpec {

    override func spec() {
        var rootViewCoordinator: RootViewCoordinator!
        let navigationController = UINavigationController()
        it ("should conform to RootViewModelCoordinatorDelegate") {
        rootViewCoordinator = RootViewCoordinator(presenter: navigationController)
            
            rootViewCoordinator.start()
            expect(rootViewCoordinator.rootViewController).toNot(beNil())
        }
    }
}
