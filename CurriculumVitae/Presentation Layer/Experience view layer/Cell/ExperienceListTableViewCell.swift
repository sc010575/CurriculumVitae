//
//  ExperienceListTableViewCell.swift
//  CurriculumVitae
//
//  Created by Suman Chatterjee on 19/01/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import UIKit

class ExperienceListTableViewCell: CVTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var jobTitle: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(_ experience: Result) {
        titleLabel.text = experience.company
        overviewLabel.text = experience.overview
        jobTitle.text = experience.title
        dateLabel.text = formattedDate(experience)
        type.text = "Job type: \(experience.jobType)"
        downloadAndDisplay(url: experience.icon)

    }
}

private extension ExperienceListTableViewCell {
    func formattedDate(_ experience: Result) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        let startDate = dateFormatterGet.date(from: experience.startDate) ?? Date()
        let endDate =  experience.endDate.count == 0 ? Date() : dateFormatterGet.date(from: experience.endDate)
        return endDate == Date() ?  "\(dateFormatterPrint.string(from: startDate)) - Till Date" : "\(dateFormatterPrint.string(from: startDate)) - \(dateFormatterPrint.string(from: endDate ?? Date()))"
    }

    func downloadAndDisplay(url stringUrl: String) {
        activityIndicator.startAnimating()
        if let url = URL(string: stringUrl) {
            posterImage.loadImage(url: url) {
                self.activityIndicator.stopAnimating()
            }
        }
    }
}
