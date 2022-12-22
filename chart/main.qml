import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.12
import QtCharts 2.3


Window {
    width: 840
    height: 480
    visible: true
    title: qsTr("Task 2")

    ChartView{
        id: chartView
        anchors.fill: parent
        title: qsTr("Метод наименьших квадратов")
        antialiasing: true
        ValueAxis {
            id: axisX
            min: 0
            max: 220
            tickCount: 23
        }

        ValueAxis {
            id: axisY
            min: 0
            max: 30
            tickCount: 7
        }
        ScatterSeries {
            id: scatter
            name: qsTr("Набор данных")
            axisX: axisX
            axisY: axisY
            Component.onCompleted: {
                chartData.setValues([7, 31, 61, 99, 129, 178, 209], [13, 10, 9, 10, 12, 20, 26])
                var x = chartData.getXvalues()
                var y = chartData.getYvalues()
                for(var index = 0; index < chartData.getSize(); ++index){
                    append(x[index], y[index])
                }
            }
        }
        LineSeries {
            id: lineQuad
            name: qsTr("Линейная функция")
            axisX: axisX
            axisY: axisY
            Component.onCompleted: {
                chartData.calculate()
                var x = chartData.getXvalues()
                var y = chartData.getYvalues()
                for(var index = 0; index < chartData.getSize(); ++index){
                    append(x[index], y[index])
                }
            }
        }
    }
}
