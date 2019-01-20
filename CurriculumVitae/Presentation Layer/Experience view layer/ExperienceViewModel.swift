//
//  ExperienceViewModel.swift
//  CurriculumVitae
//
//  Created by Suman Chatterjee on 19/01/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation

class ExperienceViewModel {

    private (set) var experiences: Box<[Result]> = Box([])

    init(_ experiences: [Result]) {
        self.experiences.value = experiences
    }

}

