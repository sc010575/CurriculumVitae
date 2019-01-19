//
//  GistMain.swift
//  CurriculumVitae
//
//  Created by Suman Chatterjee on 17/01/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation

struct GistMain:Decodable {
    let files:[String:fileDetails]
}

struct fileDetails:Decodable {
    let rawUrl:String
}
