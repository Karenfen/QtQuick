import QtQuick 2.0


Rectangle {
    id: square
    property int size: 50
    property string newColor: "#000000"
    height: size
    width: size
    antialiasing: true

    function changeColor(){
        newColor = Qt.rgba(Math.random(), Math.random(), Math.random(), Math.random())
        animColor.start()
    }


    ColorAnimation on color{
        id: animColor
        to: newColor
        duration: 500
    }

    PropertyAnimation {
        id: changeGeometry
        target: square
        property: "radius"
        to: radius == 0 ? width/2 : 0
        duration: 500
        easing.type: Easing.InCubic
    }

    RotationAnimation {
        id: rotate
        target: square
        duration: 2000
        direction: RotationAnimation.Clockwise
        from: 0
        to: 360
        easing.type: Easing.OutElastic
    }

    MouseArea{
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: if(mouse.button === Qt.LeftButton) changeColor()
                    else if(mouse.button === Qt.RightButton) rotate.start()
        onDoubleClicked: if(mouse.button === Qt.LeftButton) changeGeometry.start()
    }
}
