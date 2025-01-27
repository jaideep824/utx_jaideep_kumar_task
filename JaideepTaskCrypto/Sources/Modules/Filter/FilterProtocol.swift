//
//  FilterProtocol.swift
//  JaideepTaskCrypto
//
//  Created by Jaideep on 26/01/25.
//

import Foundation

protocol FilterViewControllerDelegate: AnyObject {
    func filterViewController(_ controller: FilterViewController, filterSelectionChanged options: [FilterOption], selectedState: [FilterOption: Bool])
}
