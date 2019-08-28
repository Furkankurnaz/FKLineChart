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
        if let bundleURL = bundle.url(forResource: "FKLineChart", withExtension: "bundle") {
            if let bundle = Bundle(url: bundleURL) {
                let nib = UINib(nibName: name, bundle: bundle)
                let view: UIView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
                view.frame = bounds
                view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
                addSubview(view)
            } else {
                assertionFailure("Could not load the bundle")
            }
        } else {
            assertionFailure("Could not create a path to the bundle")
        }
        
    }
}
