//
//  FilterViewController-CollectionView.swift
//  JaideepTaskCrypto
//
//  Created by Jaideep on 26/01/25.
//

import UIKit

extension FilterViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChipViewCollectionCell.identifier, for: indexPath) as! ChipViewCollectionCell
        let option = options[indexPath.item]
        cell.refresh(with: option, isFilterSelected: selectedState[option] != nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let option = options[indexPath.item]
        if selectedState[option] == nil {
            option.contradictoryCases.forEach {
                selectedState.removeValue(forKey: $0)
            }
            selectedState[option] = true
        } else {
            selectedState.removeValue(forKey: option)
        }
        collectionView.reloadData()
        delegate?.filterViewController(self, filterSelectionChanged: options, selectedState: selectedState)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / CGFloat(itemsInRowCount)) - 10, height: rowHeight)
    }
}
