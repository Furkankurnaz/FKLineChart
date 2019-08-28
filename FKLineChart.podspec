#
#  Be sure to run `pod spec lint FKLineChart.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

spec.name         = "FKLineChart"
spec.version      = "1.0.1"
spec.summary      = "A simple line chart with info board. "
spec.description  = "The FKLineChart is a completely customizable line chart. You can show your chart and show info board of any point when point taps."

spec.homepage     = "https://github.com/Furkankurnaz"

spec.license      = "MIT"
spec.author       = { "Furkan Kurnaz" => "furkankurnaz96@gmail.com" }

spec.platform     = :ios, "11.0"
spec.swift_version = "4.2"

spec.source       = { :git => "https://github.com/Furkankurnaz/FKLineChart.git", :tag => "1.0.1" }

spec.source_files = 'FKLineChart/*.{swift, xib, h}'

end
