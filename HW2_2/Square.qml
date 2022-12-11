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

    PropertyAnimation {
        id: animColor
        target: square
        property: "color"
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

    MouseArea{
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton
        onClicked: if(mouse.button === Qt.LeftButton) changeColor()
        onDoubleClicked: if(mouse.button === Qt.LeftButton) changeGeometry.start()
    }
}
