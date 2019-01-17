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
    let results:[Result]
    static let emptyCurriculumVitae = CurriculumVitae(profileImage: "", name: "", results: [])
}

struct Result :Decodable {
    let company:String
    let icon:String
    let startDate:String
    let endDate:String
    let overview:String
}
