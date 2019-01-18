//
//  ViewController.swift
//  CurriculumVitae
//
//  Created by Suman Chatterjee on 17/01/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    @IBOutlet weak var profileView: ProfileView!
    @IBOutlet weak var tableView: UITableView!
    var viewModel: RootViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.curriculamVitae.bind { curriculumVitae in
            self.profileView.displayProfile(curriculumVitae)
            self.tableView.isHidden = false
        }
        tableView.isHidden = true
        viewModel.getGists()
    }
}

