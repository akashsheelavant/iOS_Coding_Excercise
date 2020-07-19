//
//  FactsViewController.swift
//  iOS_Coding
//
//  Created by Akash Sheelavant - Vendor on 7/19/20.
//  Copyright © 2020 Akash Sheelavant. All rights reserved.
//

import Foundation
import UIKit

class FactsViewController: UIViewController {

    var tableView = UITableView(frame: .zero, style: .plain)
    var viewModel: FactsViewModelType?

    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        setup()
        loadData()
    }

    func setup() {
        // add tableview to the view
        view.addSubview(tableView)

        // set position using constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let guide = view.safeAreaLayoutGuide

        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true

        tableView.dataSource = self

        tableView.register(FactsTableViewCell.self, forCellReuseIdentifier: "FactsTableViewCell")
    }

    func loadData() {
        viewModel?.fetchFacts(completion: { [weak self] (status, errorMessage) in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                if status {
                    self.title = self.viewModel?.title
                    self.tableView.reloadData()
                } else {
                    self.presentError(errorMessage: errorMessage)
                }
            }
        })
    }

    func presentError(errorMessage: String?) {
        let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okButton)
        present(alertController, animated: true, completion: nil)
    }
}



extension FactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FactsTableViewCell", for: indexPath) as! FactsTableViewCell
        if let model = viewModel?.model(at: indexPath.row) {
            cell.updateCell(model: model)
        }
        return cell
    }

}
