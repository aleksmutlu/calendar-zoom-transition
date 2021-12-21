//
//  MonthView.swift
//  Calendar Zoom Transition
//
//  Created by Aleks Mutlu on 7.12.2021.
//

import UIKit

final class MonthView: UIView {
    
    let nibName = "MonthView"
    @IBOutlet var view : UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetUp()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetUp()
    }
    
    func xibSetUp() {
        view = loadViewFromNib()
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "MonthView", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}
