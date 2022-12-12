import QtQuick 2.12
import QtQuick.Controls 2.5

Page {
    width: 600
    height: 400

    header: Label {
        text: qsTr("Task 2")
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10
    }

    Square{
        size: 200
        anchors.centerIn: parent
    }
}
