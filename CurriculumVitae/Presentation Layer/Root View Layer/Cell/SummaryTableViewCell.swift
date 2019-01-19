//
//  SummaryTableViewCell.swift
//  CurriculumVitae
//
//  Created by Suman Chatterjee on 19/01/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import UIKit

class CVTableViewCell: UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static func register(tableView: UITableView) {
        tableView.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellReuseIdentifier: reuseIdentifier)
    }
}

class SummaryTableViewCell: CVTableViewCell {

    @IBOutlet weak var summaryLabel: UILabel!

    func configureSummary(_ text:String) {
        summaryLabel.text = text
    }
}
