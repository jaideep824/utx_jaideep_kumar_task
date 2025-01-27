//
//  CryptoListViewController+Table.swift
//  JaideepTaskCrypto
//
//  Created by Jaideep on 26/01/25.
//

import Foundation
import UIKit

extension CryptoListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(text: searchText)
        self.cryptoTableView.reloadData()
    }
}

extension CryptoListViewController: FilterViewControllerDelegate {
    func filterViewController(_ controller: FilterViewController, filterSelectionChanged options: [FilterOption], selectedState: [FilterOption : Bool]) {
        viewModel.filterCryptos(options, selectedState: selectedState)
    }
}

extension CryptoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredCryptoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CryptoTableViewCell.identifier, for: indexPath) as! CryptoTableViewCell
        cell.refresh(with: viewModel.filteredCryptoList[indexPath.row])
        return cell
    }
}


