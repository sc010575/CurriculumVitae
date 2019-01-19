//
//  TechnicalViewController.swift
//  CurriculumVitae
//
//  Created by Suman Chatterjee on 19/01/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import UIKit

class TechnicalViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    var viewModel: TechnicalViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Technical Skills"
        OtherTableViewCell.register(tableView: tableView)
        viewModel.technical.bind { technical in
            self.tableView.reloadSections([0], with: .top)
        }
    }
}

extension TechnicalViewController: UITableViewDelegate, UITableViewDataSource {
    func getSections() -> [[ElementsTitles]] {
        let result: [[ElementsTitles]] = [[.mainSkills], [.developmentTools, .configurationManagement, .programmingLanguage]]
        return result
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sections = getSections()
        return sections[section].count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sections = getSections()
        let title = sections[indexPath.section][indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OtherTableViewCell.reuseIdentifier, for: indexPath) as? OtherTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(sections[indexPath.section][indexPath.row].rawValue, viewModel.skills(for: title))
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return getSections().count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let wantedHeight = self.tableView(tableView, heightForHeaderInSection: section)
        let headerFrame = CGRect(origin: CGPoint.zero, size: CGSize(width: tableView.bounds.width, height: wantedHeight))
        return UIView(frame: headerFrame)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
}
