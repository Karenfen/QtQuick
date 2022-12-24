import QtQuick 2.5
import QtQuick.Controls 2.5
import "MyScrypt.js" as MyScript

Page {
    anchors.fill: parent

    header: ComboBox {
        id: figureSelection
        textRole: "text"
        valueRole: "value"
        font.pointSize: 14

        model: [
            { value: "star", text: qsTr("Звезда") },
            { value: "ring", text: qsTr("Кольцо") },
            { value: "house", text: qsTr("Дом") },
            { value: "heart", text: qsTr("Сердечко") }
        ]
        onActivated: {
            canvas.requestPaint()
        }
    }

    Canvas {
        id: canvas
        anchors.fill: parent
        antialiasing: true
        function paintRing(ctx, points){
            var pointsOut = points["out"]
            var pointsIn = points["in"]
            ctx.fillStyle = "gold"
            ctx.beginPath()
            ctx.moveTo((pointsOut[0])[0], (pointsOut[0])[1])
            for(var index = 1; index < pointsOut.length; ++index)
            {
                ctx.lineTo((pointsOut[index])[0], (pointsOut[index])[1])
            }
            ctx.closePath()
            ctx.fill()
            ctx.lineWidth = 2
            ctx.stroke()

            ctx.fillStyle = "white"
            ctx.beginPath()
            ctx.moveTo((pointsIn[0])[0], (pointsIn[0])[1])
            for(index = 1; index < pointsIn.length; ++index)
            {
                ctx.lineTo((pointsIn[index])[0], (pointsIn[index])[1])
            }
            ctx.closePath()
            ctx.fill()
            ctx.lineWidth = 2
            ctx.stroke()
        }
        function paintHouse(ctx, points){
            var pointsRoof = points["roof"]
            var pointsFacade = points["facade"]
            var pointsDoor = points["door"]
            ctx.fillStyle = "green"
            ctx.beginPath()
            ctx.moveTo((pointsRoof[0])[0], (pointsRoof[0])[1])
            for(var index = 1; index < pointsRoof.length; ++index)
            {
                ctx.lineTo((pointsRoof[index])[0], (pointsRoof[index])[1])
            }
            ctx.closePath()
            ctx.fill()
            ctx.lineWidth = 3
            ctx.stroke()

            ctx.fillStyle = "gray"
            ctx.beginPath()
            ctx.moveTo((pointsFacade[0])[0], (pointsFacade[0])[1])
            for(index = 1; index < pointsFacade.length; ++index)
            {
                ctx.lineTo((pointsFacade[index])[0], (pointsFacade[index])[1])
            }
            ctx.closePath()
            ctx.fill()
            ctx.lineWidth = 3
            ctx.stroke()

            ctx.fillStyle = "red"
            ctx.beginPath()
            ctx.moveTo((pointsDoor[0])[0], (pointsDoor[0])[1])
            for(index = 1; index < pointsDoor.length; ++index)
            {
                ctx.lineTo((pointsDoor[index])[0], (pointsDoor[index])[1])
            }
            ctx.closePath()
            ctx.fill()
            ctx.lineWidth = 2
            ctx.stroke()
        }

        function paintClock(ctx, points){

        }

        onPaint: {
            var ctx = getContext("2d")
            var points = MyScript.getFigure(width, height, figureSelection.currentValue)
            ctx.clearRect(0, 0, width, height)
            switch(figureSelection.currentValue)
            {
            case "ring":
                paintRing(ctx, points)
                break
            case "house":
                paintHouse(ctx, points)
                break
            default:
                if(figureSelection.currentValue == "heart")
                    ctx.fillStyle = "red"
                else
                    ctx.fillStyle = "gold"
                ctx.beginPath()
                ctx.moveTo((points[0])[0], (points[0])[1])
                for(var index = 1; index < points.length; ++index)
                {
                    ctx.lineTo((points[index])[0], (points[index])[1])
                }
                ctx.closePath()
                ctx.lineWidth = 5
                ctx.stroke()
                ctx.fill()
            }
        }
    }
}
