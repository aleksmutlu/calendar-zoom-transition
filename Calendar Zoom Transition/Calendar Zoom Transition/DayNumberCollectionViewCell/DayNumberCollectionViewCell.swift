//
//  DayNumberCollectionViewCell.swift
//  Calendar Zoom Transition
//
//  Created by Aleks Mutlu on 9.12.2021.
//

import UIKit

final class DayNumberCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Views
    
    @IBOutlet weak var labelNumber: UILabel!
    
    // MARK: -
    
    func configure(dayNumber: Int?) {
        if let dayNumber = dayNumber {
            labelNumber.text = "\(dayNumber)"
        } else {
            labelNumber.text = ""
        }
    }
}
