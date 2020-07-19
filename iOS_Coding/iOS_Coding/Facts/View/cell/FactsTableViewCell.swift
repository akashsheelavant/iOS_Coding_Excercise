//
//  FactsTableViewCell.swift
//  iOS_Coding
//
//  Created by Akash Sheelavant - Vendor on 7/19/20.
//  Copyright © 2020 Akash Sheelavant. All rights reserved.
//

import Foundation
import UIKit

class FactsTableViewCell: UITableViewCell {

    let factImageView = UIImageView(frame: .zero)
    let titleLabel = UILabel(frame: .zero)
    let descriptionLabel = UILabel(frame: .zero)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)

        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setup() {
        let guide = self.safeAreaLayoutGuide

        // add image view
        self.addSubview(factImageView)
        factImageView.translatesAutoresizingMaskIntoConstraints = false

        factImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0).isActive = true
        factImageView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 16.0).isActive = true
        factImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        factImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true

        let bottomAnchor = factImageView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: 0)
        bottomAnchor.priority = UILayoutPriority(500)
        bottomAnchor.isActive = true


        // adding title label
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)        
        self.addSubview(titleLabel)

        // set constraints for title label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: factImageView.trailingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        titleLabel.topAnchor.constraint(equalTo: guide.topAnchor, constant: 16).isActive = true


        // adding description label
        descriptionLabel.numberOfLines = 0
        self.addSubview(descriptionLabel)

        // set constraints for description label
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.leadingAnchor.constraint(equalTo: factImageView.trailingAnchor, constant: 16).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -8).isActive = true


    }

    func updateCell(model: FactsCellViewModelType) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
    }
}
