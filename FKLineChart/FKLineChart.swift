//
//  FKLineChart.swift
//  FKLineChart
//
//  Created by Furkan Kurnaz on 8.08.2019.
//  Copyright © 2019 Furkan Kurnaz. All rights reserved.
//

import UIKit

public protocol FKLineChartDelegate: AnyObject {
    func circleTapped(index: Int)
}

public class FKLineChart: UIView {
    
    // MARK: - Private Properties
    
    private var xPoint: CGFloat = 0
    private var stepCount: CGFloat = 0
    
    private var points: [FKLineChartPoint] = []
    private var pointCoordinates: [CGPoint] = []
    
    // MARK: - Public Properties
    
    public var pointColor: UIColor = .black
    public var lineColor: UIColor = .black
    
    public var infoBoardWidth: CGFloat = 85
    public var infoBoardHeight: CGFloat = 50
    public var infoBoardBackgroundColor: UIColor = UIColor(red: 15/255, green: 5/255, blue: 42/255, alpha: 1)
    public var infoBoardSeperatorColor: UIColor = UIColor(red: 37/255, green: 27/255, blue: 63/255, alpha: 1)
    
    public var usePointColorForTextColor: Bool = true
    public var firstTextColor: UIColor = .white
    public var secondTextColor: UIColor = .white
    
    public var lineWidth: CGFloat = 2.0
    public var circleRadius: CGFloat = 5.0
    public var circleLineWidth: CGFloat = 2.0
    
    // MARK: - Delegate
    
    public weak var delegate: FKLineChartDelegate?
    
    // MARK: - Drawing Chart Functions
    
    // calculates current context and init values, then calls drawLineChart functions.
    override public func draw(_ rect: CGRect) {
        guard let currentContext: CGContext = UIGraphicsGetCurrentContext() else {
            return
        }
        
        xPoint = -self.bounds.width / 2
        stepCount = (self.bounds.width / CGFloat(points.count - 1))
        
        drawLineChart(using: currentContext)
    }
    
    // draws line chart with calculated values.
    private func drawLineChart(using context: CGContext) {
        let centerPoint: CGPoint = CGPoint(x: self.bounds.width / 2 ,
                                           y: bounds.height)
        
        let firstPoint: CGPoint = CGPoint(x: centerPoint.x + CGFloat(xPoint),
                                          y: centerPoint.y - (bounds.height * CGFloat(points[0].percentage) / 100))
        
        pointCoordinates.append(firstPoint)
        drawCircle(point: firstPoint, color: points[0].color ?? pointColor)
        addButtonToCircle(index: 0, point: firstPoint)
        
        context.move(to: firstPoint)
        
        for (index,value) in points.enumerated() {
            if index != 0 {
                let point: CGPoint = CGPoint(x: centerPoint.x + CGFloat(xPoint),
                                             y: centerPoint.y - (bounds.height * CGFloat(value.percentage) / 100))
                
                pointCoordinates.append(point)
                drawCircle(point: point, color: value.color ?? pointColor)
                addButtonToCircle(index: index, point: point)
                
                context.addLine(to: point)
            }
            
            self.xPoint += stepCount
        }
        
        context.setLineCap(.round)
        context.setLineWidth(lineWidth)
        context.setStrokeColor(lineColor.cgColor)
        context.strokePath()
    }
    
    // draws circle with calculated values.
    private func drawCircle(point: CGPoint, color: UIColor) {
        let circlePath = UIBezierPath(arcCenter: point,
                                      radius: CGFloat(circleRadius),
                                      startAngle: CGFloat(0),
                                      endAngle:CGFloat(Double.pi * 2),
                                      clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = color.cgColor
        
        let strokeCirclePath = UIBezierPath(arcCenter: point,
                                            radius: CGFloat(circleRadius),
                                            startAngle: CGFloat(0),
                                            endAngle:CGFloat(Double.pi * 2),
                                            clockwise: true)
        
        let strokeShapeLayer = CAShapeLayer()
        strokeShapeLayer.lineWidth = circleLineWidth
        strokeShapeLayer.path = strokeCirclePath.cgPath
        strokeShapeLayer.strokeColor = lineColor.cgColor
        
        self.layer.addSublayer(strokeShapeLayer)
        self.layer.addSublayer(shapeLayer)
    }
    
    // MARK: - Adding Button To Drawn Points
    
    private func addButtonToCircle(index: Int, point: CGPoint) {
        let button =  UIButton(frame: CGRect(x: point.x - 15 ,
                                             y: point.y - 15,
                                             width: 30,
                                             height: 30))
        
        button.tag = index
        button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        
        self.addSubview(button)
    }
    
    // MARK: - Configuring Info Board
    
    private func configureInfoBoard(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, point: FKLineChartPoint) {
        let boardView: FKInfoBoardView = FKInfoBoardView(frame: CGRect(x: x,
                                                                   y: y,
                                                                   width: width,
                                                                   height: height))
        if usePointColorForTextColor {
            boardView.firstLabelColor = point.color ?? pointColor
            boardView.secondLabelColor = .white
        } else {
            boardView.firstLabelColor = firstTextColor
            boardView.secondLabelColor = secondTextColor
        }
        
        boardView.boardBackgroundColor = infoBoardBackgroundColor
        boardView.seperatorColor = infoBoardSeperatorColor
        boardView.firstText = point.firstText ?? ""
        boardView.secondText = point.secondText ?? ""
        
        if boardView.firstText != "" || boardView.secondText != "" {
            self.addSubview(boardView)
        }
        
    }
    
    // MARK: - Clearing Subviews
    
    private func clearSubviews() {
        for subview in self.subviews where ((subview as? FKInfoBoardView) != nil) {
            subview.removeFromSuperview()
        }
    }
    
    // MARK: - Handling Actions
    
    // shows a info board in the calculated area when a circle taps.
    @objc private func buttonTapped(sender: UIButton) {
        delegate?.circleTapped(index: sender.tag)
        
        clearSubviews()
        
        let centerCoordinate: CGPoint = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        let coordinate: CGPoint = pointCoordinates[sender.tag]
        let point: FKLineChartPoint = points[sender.tag]
        
        var xCoordinate: CGFloat = 0
        var yCoordinate: CGFloat = 0
        
        if coordinate.x - infoBoardWidth < -infoBoardWidth / 2 || coordinate.x + infoBoardWidth > self.bounds.width + infoBoardWidth / 2 {
            if centerCoordinate.x < coordinate.x {
                xCoordinate = coordinate.x - infoBoardWidth - circleRadius
            } else {
                xCoordinate = coordinate.x + circleRadius
            }
        } else {
            xCoordinate = coordinate.x - (infoBoardWidth / 2)
        }
        
        if centerCoordinate.y < coordinate.y {
            yCoordinate = coordinate.y - infoBoardHeight - (circleRadius * 2)
        } else {
            yCoordinate = coordinate.y + (circleRadius * 2)
        }
        
        configureInfoBoard(x: xCoordinate, y: yCoordinate, width: infoBoardWidth, height: infoBoardHeight, point: point)
    }
    
    // clears subviews of self when self view taps.
    @objc private func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        clearSubviews()
    }
    
    // MARK: - Init
    
    // calls setNeedsDisplay function to show chart with init configurations.
    public func showChart(points: [FKLineChartPoint]) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.addGestureRecognizer(tap)
        
        self.backgroundColor = .clear
        
        self.points = points
        
        setNeedsDisplay()
    }

}
