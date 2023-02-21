//
//  Extension.swift
//  FKLineChart
//
//  Created by Furkan Kurnaz on 26.08.2019.
//  Copyright © 2019 Furkan Kurnaz. All rights reserved.
//

import UIKit

extension UIView {
    func loadViewFromNib(nibName name: String) {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: name, bundle: bundle)
        let view: UIView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(view)
    }
}
