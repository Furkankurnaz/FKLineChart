//
//  FKLineChartPoint.swift
//  FKLineChart
//
//  Created by Furkan Kurnaz on 21.08.2019.
//  Copyright © 2019 Furkan Kurnaz. All rights reserved.
//

import UIKit

public struct FKLineChartPoint {
    var percentage: Int
    var color: UIColor?
    var firstText: String?
    var secondText: String?
    
    public init(percentage: Int, color: UIColor, firstText: String, secondText: String) {
        self.percentage = percentage
        self.color = color
        self.firstText = firstText
        self.secondText = secondText
    }
    
    public init(percentage: Int, color: UIColor) {
        self.percentage = percentage
        self.color = color
    }
    
    public init(percentage: Int) {
        self.percentage = percentage
    }
}
