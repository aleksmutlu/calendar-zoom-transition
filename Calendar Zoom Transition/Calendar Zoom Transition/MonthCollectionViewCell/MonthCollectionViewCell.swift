//
//  MonthCollectionViewCell.swift
//  Calendar Zoom Transition
//
//  Created by Aleks Mutlu on 6.12.2021.
//

import UIKit

enum Constants { // TODO: ?
    static let maxNumberOfWeekLines = 6
}

// MARK: - Constants

private let collectionViewInsets: UIEdgeInsets = .zero
private let minimumLineSpacingForSectionAt: CGFloat = 0
private let collectionViewInteritemSpacing: CGFloat = 0
private let cellSize: CGSize = {
    let numberOfDaysInAWeek: CGFloat = 7
    let width = ViewController.cellSize.width / numberOfDaysInAWeek
    let height = ViewController.cellSize.height
    / CGFloat(Constants.maxNumberOfWeekLines)
    
    return CGSize(width: width, height: height)
}()

final class MonthCollectionViewCell: UICollectionViewCell {

    // MARK: - Views
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    var month: Month! {
        didSet {
            displayDetails()
        }
    }
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpCollectionView()
    }
    
    // MARK: - Setup
    
    private func setUpCollectionView() {
        // TODO: Cell isimleri static olsun
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            UINib(nibName: "DayNumberCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "DayNumberCollectionViewCell"
        )
    }
    
    // MARK: - Display
    
    private func displayDetails() {
        monthLabel.text = month.title
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
 
extension MonthCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return cellSize
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return collectionViewInteritemSpacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return collectionViewInsets
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return minimumLineSpacingForSectionAt
    }
}

// MARK: UICollectionViewDelegate

extension MonthCollectionViewCell: UICollectionViewDelegate {
    
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        guard let dayNumberCell = cell as? DayNumberCollectionViewCell else {
            return
        }
        
        let dayNumberToCheck = indexPath.item + 1
        if dayNumberToCheck < month.startDayIndex {
            dayNumberCell.configure(dayNumber: nil)
        } else {
            let dayNumber = indexPath.item + 2 - month.startDayIndex
            dayNumberCell.configure(dayNumber: dayNumber)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension MonthCollectionViewCell: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return month.numberOfDays + month.startDayIndex - 1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "DayNumberCollectionViewCell",
            for: indexPath
        )
        return cell
    }
}
