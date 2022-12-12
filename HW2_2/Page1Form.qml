import QtQuick 2.12
import QtQuick.Controls 2.5

Page {
    width: 600
    height: 400
    background: Rectangle{
        anchors.fill: parent
        color: "#f7f5eb"
    }

    header: Label {
        text: qsTr("Task 1")
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10
    }

    Label {
        text: signupWin.allInfo
        anchors.centerIn: parent
    }

    SignupForm{
        id: signupWin
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
