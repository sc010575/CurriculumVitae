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
    @IBOutlet weak var rootTableView: UITableView!
    var viewModel: RootViewModelProtocol!

    private var lastContentOffset: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        createShadow()
        viewModel.curriculamVitae.bind { curriculumVitae in
            self.profileView.displayProfile(curriculumVitae)
            self.title = curriculumVitae?.name
            self.rootTableView.isHidden = false
            self.rootTableView.reloadData()
        }
        viewModel.applicationState.bind { state in
            if state == .dataError {
                self.profileView.isHidden = true
                self.errorWithMessage(message: "Data error")
                return
            }
        }
        rootTableView.isHidden = true
        SummaryTableViewCell.register(tableView: rootTableView)
        OtherTableViewCell.register(tableView: rootTableView)
        viewModel.getGists()
    }

    func errorWithMessage(message: String) {

        let alert = UIAlertController(title: "Service Error", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)

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
        viewModel.useItemAtIndex(title, indexPath.row)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset.y
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (self.lastContentOffset < scrollView.contentOffset.y) {
            // moved to top
            showShadow(true)
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y == 0.0 {
            showShadow(false)
        }
    }

    func createShadow() {
        profileView.layer.zPosition = 5000.0
        profileView.layer.shadowOpacity = 0.2
        profileView.layer.shadowRadius = 14.0
        profileView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        profileView.layer.shadowColor = UIColor.black.cgColor
        showShadow(false)
    }

    func showShadow(_ shouldShow: Bool) {
        UIView.animate(withDuration: 2.0) {
            self.profileView.layer.shadowOpacity = shouldShow ? 0.3 : 0.0
        }
    }
}
