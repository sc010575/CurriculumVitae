//
//  Constant.swift
//  CurriculumVitae
//
//  Created by Suman Chatterjee on 17/01/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation


struct Constant {
    enum QueryType: String {
        case gists
        case file = "sc010575/feb733f8c6d6c38b9db4208fb7791567"
        case none
    }
    
    static let fileId = "feb733f8c6d6c38b9db4208fb7791567"
    static let testFileUrl = "http://localhost:8088/gists/feb733f8c6d6c38b9db4208fb7791567/CurriculumVitae"
    
    static var baseURL: URL? {
        
        if isUITest || isUnitTest {
            return URL(string: "http://localhost:8088")
        }
        
        return URL(string: "https://api.github.com")
    }
    
    static var isUnitTest: Bool {
        #if targetEnvironment(simulator)
        if let _ = NSClassFromString("XCTest") {
            return true
        }
        #endif
        return false
    }
    
    static var isUITest: Bool {
        #if targetEnvironment(simulator)
        if ProcessInfo.processInfo.environment["IsLocalServerBackend"] == "true" {
            return true
        }
        #endif
        return false
    }
    
    static var isUnderTest: Bool {
        return isUITest || isUnitTest ? true : false
    }
    
    static var isSimulator: Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
}
