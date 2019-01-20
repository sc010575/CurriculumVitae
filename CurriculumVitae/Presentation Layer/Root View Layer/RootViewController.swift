//
//  ViewController.swift
//  CurriculumVitae
//
//  Created by Suman Chatterjee on 17/01/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import UIKit

enum ElementsTitles: String {
    case summary = "Professional summary"
    case technical = "Technical knowledge"
    case experience = "Experience"
    case mainSkills = "Primary Skills"
    case developmentTools = "Development Tools"
    case configurationManagement = "Configuration Management"
    case programmingLanguage = "Programming Language"
}


class RootViewController: UIViewController {

    @IBOutlet weak var profileView: ProfileView!
    @IBOutlet weak var tableView: UITableView!
    var viewModel: RootViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.curriculamVitae.bind { curriculumVitae in
            self.profileView.displayProfile(curriculumVitae)
            self.title = curriculumVitae?.name
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
        tableView.isHidden = true
        SummaryTableViewCell.register(tableView: tableView)
        OtherTableViewCell.register(tableView: tableView)
        viewModel.getGists()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MoveToTechnical" {
            guard let technicalVC = segue.destination as? TechnicalViewController,
                let technical = viewModel.curriculamVitae.value?.technicalKnowledge else{
                    return
            }
            let techViewModel = TechnicalViewModel(technical)
            technicalVC.viewModel = techViewModel
        }else if segue.identifier == "MoveToExperience" {
            guard let experienceVC = segue.destination as? ExperienceViewController,
                let experiences = viewModel.curriculamVitae.value?.results else{
                    return
            }
            let experienceViewModel = ExperienceViewModel(experiences)
            experienceVC.viewModel = experienceViewModel

        }
    }
}

extension RootViewController: UITableViewDelegate, UITableViewDataSource {

    
    func getSections() -> [[ElementsTitles]] {
        let result: [[ElementsTitles]] = [[.summary], [.technical, .experience]]
        return result
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sections = getSections()
        return sections[section].count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sections = getSections()
        let title = sections[indexPath.section][indexPath.row]

        switch title {
        case .summary:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SummaryTableViewCell.reuseIdentifier, for: indexPath) as? SummaryTableViewCell else {
                return UITableViewCell()
            }
            cell.configureSummary(viewModel.summary(for: .summary))
            return cell

        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OtherTableViewCell.reuseIdentifier, for: indexPath) as? OtherTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(sections[indexPath.section][indexPath.row].rawValue, viewModel.summary(for: title))
            return cell
        }
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sections = getSections()

        if indexPath.section >= sections.count {
            return
        }

        if indexPath.row >= sections[indexPath.section].count {
            return
        }

        let title = sections[indexPath.section][indexPath.row]

        switch title {
        case .experience:
            performSegue(withIdentifier: "MoveToExperience", sender: nil)
        case .technical:
            performSegue(withIdentifier: "MoveToTechnical", sender: nil)
        default:
            return
        }
    }
}
