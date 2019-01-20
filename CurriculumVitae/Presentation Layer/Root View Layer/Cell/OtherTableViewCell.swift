//
//  OtherTableViewCell.swift
//  CurriculumVitae
//
//  Created by Suman Chatterjee on 19/01/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import UIKit

class OtherTableViewCell: CVTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    func configure(_ title:String,_ detail:String?) {
        titleLabel.text = title
        
        guard let detail = detail else {
            detailLabel.isHidden = true
            return
        }
        detailLabel.text = detail
    }
}
