//
//  CurriculumVitae.swift
//  CurriculumVitae
//
//  Created by Suman Chatterjee on 17/01/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation

struct CurriculumVitae:Decodable {
    let profileImage:String
    let name:String
    let profile:String
    let phone:String
    let email:String
    let webSite:String?
    let address:String
    let technicalKnowledge:Technical?
    let results:[Result]
//    static let emptyCurriculumVitae = CurriculumVitae(profileImage: "",name:"",profile:"",phone:"",address:"",results: [])
}

struct Result :Decodable {
    let company:String
    let icon:String
    let startDate:String
    let endDate:String
    let overview:String
}

struct Technical : Decodable {
    let summary:String?
    let strong:[String?]
    let developmentTools:String?
    let configurationManagement:String?
    let programmingLanguage:String?
}
