////
////  PieChartReport.swift
////  Glorious Surfer
////
////  Created by Brian Seo on 2023-03-15.
////
//
//import SwiftUI
//import DeviceActivity
//
//struct PieChartReport: View {
//    let context: DeviceActivityReport.Context = .pieChart
//    let content: (PieChartView.Configuration) -> PieChartView
//    
//    func makeConfiguration(representing data: [DeviceActivityData]) -> PieChartView.Configuration {
//        var totalUsageByCategory: [ActivityCartegory: TimeInterval]
//        totalUsageByCategory = data.map { }
//    }
//}
//
//struct PieChartReport_Previews: PreviewProvider {
//    static var previews: some View {
//        PieChartReport()
//    }
//}
//
//extension DeviceActivityReport.Context {
//    static let barGraph = Self("barGraph")
//    static let pieChart = Self("pieChart")
//}
