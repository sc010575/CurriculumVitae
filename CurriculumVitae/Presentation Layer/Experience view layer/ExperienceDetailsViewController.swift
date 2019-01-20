//
//  ExperienceDetailsViewController.swift
//  CurriculumVitae
//
//  Created by Suman Chatterjee on 20/01/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import UIKit

class ExperienceDetailsViewController: UIViewController {
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var responseLabel: UILabel!
    var experience: Result!
    override func viewDidLoad() {
        super.viewDidLoad()
        buildExperience()
    }
}

private extension ExperienceDetailsViewController {
    func buildExperience() {
        jobTitleLabel.text = experience.title
        companyLabel.text = experience.company
        var response = ""
        for str in experience.responsibility {
            if let strongStr = str {
                response = response + "• " + strongStr + "\n\n"
            }
        }
        responseLabel.text = response
    }
}
