import QtQuick 2.0
import QtQuick.Controls 2.12


Rectangle {
        id: headerRect
        height: 30
        width: 400
        property bool running: searchAnim.running

        SequentialAnimation {
            id: searchAnim

            PropertyAnimation {
                target: searchButton
                property: "visible"
                to: false
                duration: 0
            }

            PropertyAnimation {
                target: busyIndicator
                properties: "visible,running"
                to: true
                duration: 0
            }

            PauseAnimation {
                duration: 5000
            }

            PropertyAnimation {
                target: busyIndicator
                properties: "visible,running"
                to: false
                duration: 0
            }

            PropertyAnimation {
                target: searchButton
                property: "visible"
                to: true
                duration: 0
            }
        }

        TextField {
            id: searchField
            width: parent.width - searchButton.width - 10
            height: parent.height
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            leftPadding: 8
            topPadding: 0
            bottomPadding: 8
        }

        Button {
            id: searchButton
            text: qsTr("Поиск")
            height: parent.height
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            onClicked: searchAnim.start()
        }

        BusyIndicator {
            id: busyIndicator
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            height: parent.height
            running: false
        }
    }
