//
//  FactsViewModel.swift
//  iOS_Coding
//
//  Created by Akash Sheelavant - Vendor on 7/19/20.
//  Copyright © 2020 Akash Sheelavant. All rights reserved.
//

import Foundation

protocol FactsViewModelType {
    var title: String? { get }

    func fetchFacts(completion: @escaping ((Bool, String?) -> Void))
    func numberOfRows() -> Int
    func model(at index: Int) -> FactsCellViewModelType?
}

protocol FactsCellViewModelType {
    var title: String? { get }
    var description: String? { get }
    var imageUrl: String? { get }
}

class FactsViewModel: FactsViewModelType {
    var title: String?
    var facts = [Info]()
    private let networkManager: NetworkManagerType

    init(networkManager: NetworkManagerType) {
        self.networkManager = networkManager
    }

    func fetchFacts(completion: @escaping ((Bool, String?) -> Void)) {
        networkManager.fetchFacts { [weak self] (response, error) in
            guard let `self` = self else { return }
            if let error = error {
                completion(false, error)
            }

            if let response = response {
                self.title = response.title
                self.facts = response.rows ?? []

                completion(true, nil)
            }
        }
    }

    func numberOfRows() -> Int {
        return facts.count
    }

    func model(at index: Int) -> FactsCellViewModelType? {
        if index < facts.count {
            return facts[index]
        }
        return nil
    }
}


extension Info: FactsCellViewModelType {}
