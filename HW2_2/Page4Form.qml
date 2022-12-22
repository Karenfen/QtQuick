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

        LineSeries {
            id: seriesLine
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
            Component.onCompleted: {
                chartParam.type = 3
                seriesQuad.name =  chartParam.label
                for(var index = 0; index < chartParam.size; ++index){
                    seriesLog.append(chartParam.Xvalues[index], chartParam.Yvalues[index])
                }
            }
        }
        LineSeries {
            id: seriesSin
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
