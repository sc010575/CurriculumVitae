//
//  ExperienceViewModel.swift
//  CurriculumVitae
//
//  Created by Suman Chatterjee on 19/01/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation

class ExperienceViewModel {

    private (set) var experiences: Box<[Resultdata]> = Box([])

    init(_ experiences: [Resultdata]) {
        self.experiences.value = experiences
    }

}

