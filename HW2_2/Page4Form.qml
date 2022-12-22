import QtQuick 2.12
import QtQuick.Controls 2.5
import QtCharts 2.15



Page {
    width: 640
    height: 480

    ChartView {
        id: chartView
        anchors.fill: parent
        title: qsTr("Зависимость Y от X")
        antialiasing: true

        ValueAxis {
            id: axisX
            min: 0
            max: 5
        }

        ValueAxis {
            id: axisY
            min: -5
            max: 25
        }
        LineSeries {
            id: seriesLine
            axisX: axisX
            axisY: axisY
            Component.onCompleted: {
                chartParam.type = 0
                seriesLine.name = chartParam.label
                for(var index = 0; index < chartParam.size; ++index){
                    seriesLine.append(chartParam.Xvalues[index], chartParam.Yvalues[index])
                }
            }
        }
        LineSeries {
            id: seriesAbs
            axisX: axisX
            axisY: axisY
            Component.onCompleted: {
                chartParam.type = 1
                seriesAbs.name  = chartParam.label
                for(var index = 0; index < chartParam.size; ++index){
                    seriesAbs.append(chartParam.Xvalues[index], chartParam.Yvalues[index])
                }
            }
        }
        LineSeries {
            id: seriesQuad
            axisX: axisX
            axisY: axisY
            Component.onCompleted: {
                chartParam.type = 2
                seriesQuad.name  = chartParam.label
                for(var index = 0; index < chartParam.size; ++index){
                    seriesQuad.append(chartParam.Xvalues[index], chartParam.Yvalues[index])
                }
            }
        }
        LineSeries {
            id: seriesLog
            axisX: axisX
            axisY: axisY
            Component.onCompleted: {
                chartParam.type = 3
                seriesLog.name =  chartParam.label
                for(var index = 0; index < chartParam.size; ++index){
                    seriesLog.append(chartParam.Xvalues[index], chartParam.Yvalues[index])
                }
            }
        }
        LineSeries {
            id: seriesSin
            axisX: axisX
            axisY: axisY
            Component.onCompleted: {
                chartParam.type = 4
                seriesSin.name =  chartParam.label
                for(var index = 0; index < chartParam.size; ++index){
                    seriesSin.append(chartParam.Xvalues[index], chartParam.Yvalues[index])
                }
            }
        }
    }

}
