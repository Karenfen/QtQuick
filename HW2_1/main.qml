import QtQuick 2.12
import QtQuick.Window 2.12



Window {
    width: 640
    height: 480
    color: "#f7f1df"
    visible: true
    title: qsTr("Home Work 2.1")

    Text {
        id: enteredData
        text: signupWin.allInfo
        anchors.fill: parent
        font.pixelSize: 14
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignTop
    }

    SignupForm{
        id: signupWin
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }
}
