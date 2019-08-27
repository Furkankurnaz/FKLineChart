//
//  FKInfoBoardView.swift
//  FKLineChart
//
//  Created by Furkan Kurnaz on 26.08.2019.
//  Copyright © 2019 Furkan Kurnaz. All rights reserved.
//

import UIKit

public class FKInfoBoardView: UIView {
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var seperatorView: UIView!
    
    var firstText: String = "" {
        didSet {
            firstLabel.text = firstText
        }
    }
    
    var firstLabelColor: UIColor = .clear {
        didSet {
            firstLabel.textColor = firstLabelColor
        }
    }
    
    var secondText: String = "" {
        didSet {
            secondLabel.text = secondText
        }
    }
    
    var secondLabelColor: UIColor = .clear {
        didSet {
            secondLabel.textColor = secondLabelColor
        }
    }
    
    var boardBackgroundColor: UIColor = .clear {
        didSet {
            self.backgroundColor = boardBackgroundColor
        }
    }
    
    var seperatorColor: UIColor = .clear {
        didSet {
            self.seperatorView.backgroundColor = seperatorColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        loadViewFromNib(nibName: "FKInfoBoardView")
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 2
    }
    
}
