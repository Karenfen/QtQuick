import QtQuick 2.0


Rectangle {
    id: square
    property int size: 100
    property string newColor: "#000000"
    height: size
    width: size
    anchors.centerIn: parent
    antialiasing: true

    function changeColor(){
        newColor = Qt.rgba(Math.random(), Math.random(), Math.random(), 1)
        animColor.start()
    }

    function changeGeometry(){
        animGeometry.stop()
        animGeometry.start()
    }

    function rotate(){
        animRotate.stop()
        animRotate.start()
    }

    ColorAnimation on color{
        id: animColor
        to: newColor
        duration: 500
    }

    PropertyAnimation {
        id: animGeometry
        target: square
        property: "radius"
        to: radius == 0 ? width/2 : 0
        duration: 500
        easing.type: Easing.InCubic
    }

    RotationAnimation {
        id: animRotate
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
                    else if(mouse.button === Qt.RightButton) rotate()
        onDoubleClicked: if(mouse.button === Qt.LeftButton) changeGeometry()
    }
}
