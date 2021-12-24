//
//  ViewController.swift
//  Calendar Zoom Transition
//
//  Created by Aleks Mutlu on 6.12.2021.
//

import UIKit

// MARK: - Constants

private let collectionViewInsets = UIEdgeInsets(
    top: 0,
    left: 16,
    bottom: 0,
    right: 16
)
private let collectionViewInteritemSpacing: CGFloat = 8

class ViewController: UIViewController {

    // MARK: - UI
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    static let cellSize: CGSize = {
        let numberOfColumns: CGFloat = 3
        let screenWidthWithoutInsets = UIScreen.main.bounds.width
        - collectionViewInsets.left - collectionViewInsets.right
        
        let totalInsetitemSpacings = collectionViewInteritemSpacing
        * (numberOfColumns - 1)
        
        let width = (screenWidthWithoutInsets - totalInsetitemSpacings)
        / numberOfColumns
        
        let height: CGFloat = 200
        
        return CGSize(width: width, height: height)
    }()
    
    private let calendarManager = CalendarManager()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()
        
        displayMonths()
    }

    // MARK: - Setup
    
    private func setUpCollectionView() {
        collectionView.register(
            UINib(nibName: "MonthCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "MonthCollectionViewCell"
        )
    }

    // MARK: - Months
    
    private func displayMonths() {
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return ViewController.cellSize
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
}

// MARK: - UICollectionViewDelegate

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        guard let monthCell = cell as? MonthCollectionViewCell else { return }
        monthCell.month = calendarManager.months[indexPath.item]
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let month = calendarManager.months[indexPath.item]
        print("Did select month: \(month.title)")
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.2, animations: {
            cell?.alpha = 0.5
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.alpha = 1
    }
}

// MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return calendarManager.months.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "MonthCollectionViewCell",
            for: indexPath
        ) as! MonthCollectionViewCell
        return cell
    }
}
