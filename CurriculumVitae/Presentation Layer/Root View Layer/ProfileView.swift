//
//  ProfileView.swift
//  CurriculumVitae
//
//  Created by Suman Chatterjee on 18/01/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import UIKit


class ProfileView: UIView {
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var webSiteLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        displayProfile(nil)
    }
}

extension ProfileView {
    func displayProfile(_ curriculmVitae: CurriculumVitae?) {
        if let curriculmVitae = curriculmVitae {

            if let url = URL(string: curriculmVitae.profileImage) {
                imageView.loadImage(url: url, completion: {
                    self.loadingIndicator?.stopAnimating()
                    self.imageView.layer.cornerRadius = 10
                })
            }
            addressLabel.text = curriculmVitae.address
            phoneLabel.text = curriculmVitae.phone
            emailLabel.text = curriculmVitae.email
            webSiteLabel.text = curriculmVitae.webSite
            hideLabel(false)

        } else {
            addressLabel.text = "Loading..."
            hideLabel(true)
            loadingIndicator?.startAnimating()
            imageView.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            imageView.layer.cornerRadius = 10
        }
    }
    
    private func hideLabel(_ hide:Bool) {
        phoneLabel.isHidden = hide
        emailLabel.isHidden = hide
        webSiteLabel.isHidden = hide
    }
}
