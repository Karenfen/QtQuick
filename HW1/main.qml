import QtQuick 2.12
import QtQuick.Controls 2.5



ApplicationWindow {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Stack")

    header: ToolBar {
        contentHeight: toolButton.implicitHeight

        ToolButton {
            id: toolButton
            text: stackView.depth > 1 ? "\u25C0" : "\u2630"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop()
                } else {
                    drawer.open()
                }
            }
        }

        Label {
            text: stackView.currentItem.title
            anchors.centerIn: parent
        }
    }

    Drawer {
        id: drawer
        width: window.width * 0.66
        height: window.height

        Column {
            anchors.fill: parent

            ItemDelegate {
                text: qsTr("Page 1")
                width: parent.width
                onClicked: {
                    stackView.push("Page1Form.ui.qml")
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Page 2")
                width: parent.width
                onClicked: {
                    stackView.push("Page2Form.ui.qml")
                    drawer.close()
                }
            }
        }
    }

    StackView {
        id: stackView
        initialItem: "HomeForm.ui.qml"
        anchors.fill: parent
    }

    Rectangle{
        id: loginWindow
        color: "#d6d6d6"
        anchors.centerIn: parent
        radius: 5
        width: 300
        height: 250
        property string textColor: "#535353"
        property string login: "login"
        property string password: "password"

        ParallelAnimation{
            id: failAnimation

            SequentialAnimation {
                PropertyAnimation {
                    targets: [loginTextField, passwordTextField]
                    property: "color"
                    to: "dark red"
                    duration: 0
                    }

                PropertyAnimation {
                    targets: [loginTextField, passwordTextField]
                    property: "color"
                    to: loginWindow.textColor
                    duration: 400
                }
            }

            SequentialAnimation {
                NumberAnimation {
                    target: loginWindow
                    property: "anchors.horizontalCenterOffset"
                    to: -5
                    duration: 50
                }

                NumberAnimation {
                    target: loginWindow
                    property: "anchors.horizontalCenterOffset"
                    to: 5
                    duration: 100
                }

                NumberAnimation {
                    target: loginWindow
                    property: "anchors.horizontalCenterOffset"
                    to: 0
                    duration: 50
                }
            }
        }

        SequentialAnimation{
            id: successAnimation

            PropertyAnimation {
                targets: [loginTextField, passwordTextField, submitButton]
                property: "opacity"
                to: 0
                duration: 400
            }

            PropertyAnimation {
                target: loginWindow
                property: "opacity"
                to: 0
                duration: 600
            }

            PropertyAction {
                target: loginWindow
                property: "visible"
                value: false
            }
        }


        function checkCredentials() {
            if (login === loginTextField.text && password === passwordTextField.text)
                successAnimation.start()
            else
                failAnimation.start()
        }

        Column {
            anchors.fill: parent
            padding: 32
            spacing: 32

            TextField {
                id: loginTextField
                anchors.horizontalCenter: parent.horizontalCenter
                placeholderText: qsTr("Логин")
                color: loginWindow.textColor
                Keys.onEnterPressed: loginWindow.checkCredentials()
                Keys.onReturnPressed: loginWindow.checkCredentials()
            }

            TextField {
                id: passwordTextField
                echoMode: TextInput.Password
                anchors.horizontalCenter: parent.horizontalCenter
                placeholderText: qsTr("Пароль")
                color: loginWindow.textColor
                Keys.onEnterPressed: loginWindow.checkCredentials()
                Keys.onReturnPressed: loginWindow.checkCredentials()
            }

            Button {
                id: submitButton
                width: 200
                height: 40
                background: Rectangle {
                    color: parent.down ? "#bbbbbb" :
                    (parent.hovered ? "#AEDE48" : "#87D65A")
                }
                text: qsTr("Вход")
                anchors.horizontalCenter: parent.horizontalCenter
                Keys.onEnterPressed: loginWindow.checkCredentials()
                Keys.onReturnPressed: loginWindow.checkCredentials()
                onClicked: loginWindow.checkCredentials()
            }
        }
    }

}
