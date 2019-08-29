# FKLineChart

## Installation

### CocoaPods

Add the following entry to your Podfile:

```rb
pod 'FKLineChart'
```

Then run:

```rb
pod install
```

Don't forget to import FKLineChart in every file you'd like to use line chart :

```swift
import FKLineChart
```

## Usage

1- Add a UIView to your storyboard and set its custom class `FKLineChart`.

<img src="https://github.com/Furkankurnaz/FKLineChart/blob/master/usageImages/1.png"/>

2- Create an outlet of view you created.

```swift
@IBOutlet weak var lineChart: FKLineChart!
```

3- Create an array that holds `FKLineChartPoint` objects. For this there are three options:

<img src="https://github.com/Furkankurnaz/FKLineChart/blob/master/usageImages/2.png"/>

If you want to see info board when you tap a point, then use third one.

4- After you created the array like this: 

```swift
var pointsArray: [FKLineChartPoint] = [
        FKLineChartPoint(percentage: 30, color: .red, firstText: "First 1", secondText: "Second 1"),
        FKLineChartPoint(percentage: 50, color: .yellow, firstText: "First 2", secondText: "Second 2"),
        FKLineChartPoint(percentage: 40, color: .green, firstText: "First 3", secondText: "Second 3"),
        FKLineChartPoint(percentage: 70, color: .cyan, firstText: "First 4", secondText: "Second 4"),
        FKLineChartPoint(percentage: 60, color: .orange, firstText: "First 5", secondText: "Second 5"),
    ]
```

Now you can show line chart:

```swift
override func viewDidLoad() {
        super.viewDidLoad()
        
        lineChart.showChart(points: pointsArray)
}
```

### Result

<img src="https://github.com/Furkankurnaz/FKLineChart/blob/master/usageImages/3.png" width="400" height="300"/>

<img src="https://github.com/Furkankurnaz/FKLineChart/blob/master/usageImages/4.png" width="400" height="300"/>

## Advance Usage

You can customize your chart as you wish! :

```swift
lineChart.lineWidth = 2.0
lineChart.lineColor = .black
lineChart.circleLineWidth = 2.0
lineChart.circleRadius = 5.0
lineChart.infoBoardBackgroundColor = UIColor(red: 15/255, green: 5/255, blue: 42/255, alpha: 1)
lineChart.infoBoardSeperatorColor = UIColor(red: 37/255, green: 27/255, blue: 63/255, alpha: 1)
lineChart.infoBoardWidth = 85
lineChart.infoBoardHeight = 50
```

And if you want change texts colors:

```swift
lineChart.usePointColorForTextColor = false
lineChart.firstTextColor = .white
lineChart.secondTextColor = .red
```
