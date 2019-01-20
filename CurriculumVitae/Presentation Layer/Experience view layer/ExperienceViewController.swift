//
//  ExperienceViewController.swift
//  CurriculumVitae
//
//  Created by Suman Chatterjee on 19/01/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import UIKit

class ExperienceViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    var viewModel: ExperienceViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Experience"
        viewModel.experiences.bind { experiences in
            self.tableView.reloadSections([0], with: .top)
        }
    }


    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MoveToExperienceDetails" {
            guard let experience = sender as? Result,
            let exDetailsVC = segue.destination as? ExperienceDetailsViewController else { return }
            exDetailsVC.experience = experience
        }
    }
}

extension ExperienceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.experiences.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExperienceListTableViewCell.reuseIdentifier, for: indexPath) as? ExperienceListTableViewCell else {
            return UITableViewCell()
        }
        let experience = viewModel.experiences.value[indexPath.row]
        cell.configureCell(experience)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let experience = viewModel.experiences.value[indexPath.row]
        performSegue(withIdentifier: "MoveToExperienceDetails", sender: experience)
    }
}
