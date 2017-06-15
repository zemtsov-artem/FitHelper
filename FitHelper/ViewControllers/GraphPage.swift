//
//  GraphPage.swift
//  FitHelper
//
//  Created by артем on 10.05.17
//  Copyright © 2017 артем. All rights reserved.
//

import UIKit
import SwiftCharts

class GraphPage: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var nameOfExercise: UITextField!
    var exercisePickerView:UIPickerView?
    var equalsFiniliseTrainings:[FinalisedTraining]!
    
    fileprivate var chart: Chart? // arc
    var pickOption:[String] = []
    private let defalutEmptyExerciseList:[String] = ["Нет тренировок"]
    private var allWeightsOfCurrentTraining:[Int] = []
    private var allDates:[String] = []
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOption.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickOption[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        equalsFiniliseTrainings = FinalisedTraining.allFinalisedTrainingsWithEqualsName(inputName: pickOption[row])
        preparation(equalsFiniliseTrainings)
        nameOfExercise.text = pickOption[row]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        view.endEditing(true)
    }

    
    private func appendInMyArrFromFinalisedExercises(from:FinalisedTraining,to:[String]) {
        if !(existInArray(name: from.name!, inArray: pickOption)){
            pickOption.append(from.name!)
        }
        
    }
    
    private func existInArray(name:String,inArray:[String]) ->Bool{
        for item in inArray {
            if item == name {
                return true
            }
        }
        return false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exercisePickerView = UIPickerView()
        exercisePickerView?.delegate = self
        nameOfExercise.inputView = exercisePickerView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let allFinalisedTrainings:[FinalisedTraining] = FinalisedTraining.allFinalisedTrainings()
        if allFinalisedTrainings.count > 0 {
            for item in allFinalisedTrainings{
                appendInMyArrFromFinalisedExercises(from: item, to: pickOption)
            }
        } else {
            pickOption = defalutEmptyExerciseList
        }
        if pickOption != defalutEmptyExerciseList{
            if nameOfExercise.text == nil || nameOfExercise.text == ""{
                 nameOfExercise.text = pickOption.first
            }
            equalsFiniliseTrainings = FinalisedTraining.allFinalisedTrainingsWithEqualsName(inputName: nameOfExercise.text!)
            preparation(equalsFiniliseTrainings)
        }
    }
    
    private func getAllWeightFromArrayOfFinalisedTrainings(_ input:FinalisedTraining)->Int{
        let finalisedExercises = input.finalisedExercises
        var result = 0
        for exercise in finalisedExercises!{
            if let value = exercise as? FinalisedExercise{
                for item in value.seriesWeightValues!{
                    result += Int(item)
                }
            }
        }
        return result
    }
    private func isExistInArray(name:String,checkIn:[String]) ->Bool{
        for item in checkIn {
            if name == item {
                return true
            }
        }
        return false
    }
    
    private func preparation( _ inputEqualsFinalisedExercisesArray:[FinalisedTraining]){
        let myCount = inputEqualsFinalisedExercisesArray.count
        var weightValues:[Int] = []
        var dateValues:[String] = []
        var minWeight = 0
        var maxWeight = 13
        if (inputEqualsFinalisedExercisesArray.first != nil) && getAllWeightFromArrayOfFinalisedTrainings(inputEqualsFinalisedExercisesArray.first!) != 0{
            maxWeight = getAllWeightFromArrayOfFinalisedTrainings(inputEqualsFinalisedExercisesArray.first!)
        }
        for index in 0..<myCount{
            let weightSum = getAllWeightFromArrayOfFinalisedTrainings(inputEqualsFinalisedExercisesArray[index])
            if weightSum > maxWeight{
                maxWeight = weightSum
            }
            if weightSum < minWeight {
                minWeight = weightSum
            }
//            if !(isExistInArray(name:getDate(inputNSDate: inputEqualsFinalisedExercisesArray[index].date!),
//                               checkIn:dateValues)){
//
//            }
            weightValues.append(weightSum)
            dateValues.append(getDate(inputNSDate: inputEqualsFinalisedExercisesArray[index].date!))
            
        }

        let labelSettings = ChartLabelSettings(font: UIFont(name: "Helvetica", size: 11) ?? UIFont.systemFont(ofSize: 11))
        
        var readFormatter = DateFormatter()
        readFormatter.dateFormat = "dd.MM.yyyy"
        
        var displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "dd.MM.yyyy"
        
        let date = {(str: String) -> Date in
            return readFormatter.date(from: str)!
        }
        
        let calendar = Calendar.current
        
        let dateWithComponents = {(day: Int, month: Int, year: Int) -> Date in
            var components = DateComponents()
            components.day = day
            components.month = month
            components.year = year
            return calendar.date(from: components)!
        }
        
        func filler(_ date: Date) -> ChartAxisValueDate {
            let filler = ChartAxisValueDate(date: date, formatter: displayFormatter)
            filler.hidden = true
            return filler
        }
        
        var chartPoints:[ChartPoint] = []
       
        for index in 0..<myCount{
            chartPoints.append(createChartPoint(dateStr: dateValues[index], value: Double(weightValues[index]), readFormatter: readFormatter, displayFormatter: displayFormatter))
        }
        
        let yValues = stride(from: minWeight, through: maxWeight + (maxWeight - minWeight) / 5, by: (maxWeight - minWeight) / 5).map {ChartAxisValuePercent($0, labelSettings: labelSettings)}
        
        var xValues:[ChartAxisValue] = []
        for index in 0..<myCount{
            xValues.append(createDateAxisValue(dateValues[index], readFormatter: readFormatter, displayFormatter: displayFormatter))
        }
        
        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "Дата", settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "Количество кг", settings: labelSettings.defaultVertical()))
        let chartFrame = chartFramee(view.bounds)
        
        
        var chartSettings = ChartSettings()
        chartSettings.leading = 10
        chartSettings.top = 10
        chartSettings.trailing = 10
        chartSettings.bottom = 10
        chartSettings.labelsToAxisSpacingX = 5
        chartSettings.labelsToAxisSpacingY = 5
        chartSettings.axisTitleLabelsToLabelsSpacing = 4
        chartSettings.axisStrokeWidth = 0.2
        chartSettings.spacingBetweenAxesX = 8
        chartSettings.spacingBetweenAxesY = 8
        chartSettings.labelsSpacing = 0
        
        chartSettings.zoomPan.panEnabled = true
        chartSettings.zoomPan.zoomEnabled = true
        chartSettings.trailing = 80
        
        // Set a fixed (horizontal) scrollable area 2x than the original width, with zooming disabled.
        chartSettings.zoomPan.maxZoomX = 2
        chartSettings.zoomPan.minZoomX = 2
        chartSettings.zoomPan.minZoomY = 1
        chartSettings.zoomPan.maxZoomY = 1
        
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxisLayer, yAxisLayer, innerFrame) = (coordsSpace.xAxisLayer, coordsSpace.yAxisLayer, coordsSpace.chartInnerFrame)
        
        let lineModel = ChartLineModel(chartPoints: chartPoints, lineColor: UIColor.red, lineWidth: 2, animDuration: 1, animDelay: 0)
        
        // delayInit parameter is needed by some layers for initial zoom level to work correctly. Setting it to true allows to trigger drawing of layer manually (in this case, after the chart is initialized). This obviously needs improvement. For now it's necessary.
        let chartPointsLineLayer = ChartPointsLineLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, lineModels: [lineModel], delayInit: true)
        
        let guidelinesLayerSettings = ChartGuideLinesLayerSettings(linesColor: UIColor.black, linesWidth: 0.3)
        let guidelinesLayer = ChartGuideLinesLayer(xAxisLayer: xAxisLayer, yAxisLayer: yAxisLayer, settings: guidelinesLayerSettings)
        
        let chart = Chart(
            frame: chartFrame,
            innerFrame: innerFrame,
            settings: chartSettings,
            layers: [
                xAxisLayer,
                yAxisLayer,
                guidelinesLayer,
                chartPointsLineLayer]
        )
        if let viewToRemove = self.chart?.view{
            view.willRemoveSubview(viewToRemove)
            for v in view.subviews{
                if (v is ChartBaseView) {
                    v.removeFromSuperview()
                }
            }
            view.addSubview(chart.view)
        } else {
            view.addSubview(chart.view)
        }
        
        
        
        // Set scrollable area 2x than the original width, with zooming enabled. This can also be combined with e.g. minZoomX to allow only larger zooming levels.
        //        chart.zoom(scaleX: 2, scaleY: 1, centerX: 0, centerY: 0)
        
        // Now that the chart is zoomed (either with minZoom setting or programmatic zooming), trigger drawing of the line layer. Important: This requires delayInit paramter in line layer to be set to true.
        chartPointsLineLayer.initScreenLines(chart)
        
        
        self.chart = chart
    }
    
    func createChartPoint(dateStr: String, value: Double, readFormatter: DateFormatter, displayFormatter: DateFormatter) -> ChartPoint {
        return ChartPoint(x: createDateAxisValue(dateStr, readFormatter: readFormatter, displayFormatter: displayFormatter), y: ChartAxisValuePercent(value))
    }
    
    func createDateAxisValue(_ dateStr: String, readFormatter: DateFormatter, displayFormatter: DateFormatter) -> ChartAxisValue {
        let date = readFormatter.date(from: dateStr)!
        let labelSettings = ChartLabelSettings(font: UIFont(name: "Helvetica", size: 11) ?? UIFont.systemFont(ofSize: 11), rotation: 45, rotationKeep: .top)
        return ChartAxisValueDate(date: date, formatter: displayFormatter, labelSettings: labelSettings)
    }
    
    class ChartAxisValuePercent: ChartAxisValueDouble {
        override var description: String {
            return "\(formatter.string(from: NSNumber(value: scalar))!)кг"
        }
    }
    
    private func chartFramee(_ containerBounds: CGRect) -> CGRect {
        return CGRect(x: 10, y:85, width: containerBounds.size.width, height: containerBounds.size.height - 150)
    }

    private func getDate(inputNSDate:NSDate) ->String{
        let dayFormatter: DateFormatter = DateFormatter()
        dayFormatter.dateFormat = "dd"
        let monthFormatter: DateFormatter = DateFormatter()
        monthFormatter.dateFormat = "MM"
        let yearFormatter: DateFormatter = DateFormatter()
        yearFormatter.dateFormat = "YYYY"
        
        return (dayFormatter.string(from: inputNSDate as Date) + "." +
            monthFormatter.string(from: inputNSDate as Date) + "." +
            yearFormatter.string(from: inputNSDate as Date)
        )
    }
}
