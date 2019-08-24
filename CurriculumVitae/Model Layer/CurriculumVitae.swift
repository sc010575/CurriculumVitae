//
//  CurriculumVitae.swift
//  CurriculumVitae
//
//  Created by Suman Chatterjee on 17/01/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation

struct CurriculumVitae:Model {
    let profileImage:String
    let name:String
    let profile:String
    let phone:String
    let email:String
    let webSite:String?
    let address:String
    let technicalKnowledge:Technical?
    let results:[Resultdata]
}

struct Resultdata :Model {
    let company:String
    let icon:String
    let startDate:String
    let endDate:String
    let overview:String
    let title:String
    let jobType:String
    let responsibility:[String?]
}

struct Technical : Model {
    let summary:String?
    let strong:[String?]
    let developmentTools:String?
    let configurationManagement:String?
    let programmingLanguage:String?
    static let emptyTechnical = Technical(summary: "", strong: [], developmentTools: "", configurationManagement: "", programmingLanguage: "")
}
