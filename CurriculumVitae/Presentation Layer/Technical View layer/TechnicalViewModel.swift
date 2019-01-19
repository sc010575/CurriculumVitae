//
//  TechnicalViewModel.swift
//  CurriculumVitae
//
//  Created by Suman Chatterjee on 19/01/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation

class TechnicalViewModel {

    private (set) var technical: Box<Technical> = Box(Technical.emptyTechnical)

    init(_ technical: Technical) {
        self.technical.value = technical
    }

    func skills(for section: ElementsTitles) -> String? {

        switch section {
        case .mainSkills:
            var strongSkill = ""
            let strongSkills = technical.value.strong
            for str in strongSkills {
                if let strongStr = str {
                    strongSkill = strongSkill + " • " + strongStr + "\n"
                }
            }
            return strongSkill
        case .developmentTools:
            return technical.value.developmentTools
        case .configurationManagement:
            return technical.value.configurationManagement
        case .programmingLanguage:
            return technical.value.programmingLanguage
        default:
            return nil
        }
    }

}
