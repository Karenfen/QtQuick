import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15


Rectangle {
    id: rootPage
    height: 400
    width: 400
    color: "#fafaf0"
    radius: 20
    property string result: qsTr("Result")
    signal searchAgain()
    signal ok()

    onResultChanged: {
        proccesIndicator.running = false
        againButton.enabled = true
    }

    ScrollView {
        id: scroll
        width: 350
        height: 300
        anchors.horizontalCenter: rootPage.horizontalCenter
        anchors.top: rootPage.top
        anchors.margins: 20

        TextArea {
            width: parent.width
            height: parent.height
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            readOnly: true
            wrapMode: TextEdit.Wrap
            text: rootPage.result
        }
    }

    Button {
        id: okButton
        width: 100
        height: 50
        anchors.left: rootPage.horizontalCenter
        anchors.bottom: rootPage.bottom
        anchors.margins: 10
        text: qsTr("Ok")
        font.pointSize: 14
        state: "default"

        background: Rectangle {
            id: okButtonBack
            anchors.fill: parent
            color: "#0fd142"
            radius: height/2
        }

        states: State {
            name: "pressed"
            when: okButton.down
            PropertyChanges {
                target: okButtonBack
                color: "#93faaf"
            }
        }

        onClicked: {
            rootPage.visible = false
            rootPage.result = ""
            rootPage.ok()
        }
    }

    Button {
        id: againButton
        width: 100
        height: 50
        anchors.right: rootPage.horizontalCenter
        anchors.bottom: rootPage.bottom
        anchors.margins: 10
        text: qsTr("Again")
        font.pointSize: 14
        state: "default"

        background: Rectangle {
            id: againButtonBack
            anchors.fill: parent
            color: "#0fd142"
            radius: height/2
        }

        states: State {
            name: "pressed"
            when: againButton.down
            PropertyChanges {
                target: againButtonBack
                color: "#93faaf"
            }
        }

      onClicked: {
            result = ""
            proccesIndicator.running = true
            enabled = false
            rootPage.searchAgain()
        }
    }

    BusyIndicator {
        id: proccesIndicator
        anchors.centerIn: parent
        width: 100
        height: 100
        running: false
    }
}
