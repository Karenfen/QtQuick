import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import com.Calculate 1.0


Window {
    id: root
    width: 400
    height: 800
    visible: true
    title: qsTr("Hello World")

    Calculate{
        id: calc
    }

    Page {
        id: task1
        width: 400
        height: 400

        function calculate(){
            textResult.text = calc.heronArea(spinBoxA.value, spinBoxB.value, spinBoxC.value)
        }

        Image {
            id: image
            x: 9
            y: 0
            width: 581
            height: 100
            source: "formul.bmp"
            fillMode: Image.PreserveAspectFit
        }

        Label {
            id: labelA
            x: 9
            y: 106
            width: 80
            height: 30
            text: "a"
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        Label {
            id: labelB
            x: 9
            y: 143
            width: 80
            height: 31
            text: qsTr("b")
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        Label {
            id: labelC
            x: 9
            y: 180
            width: 80
            height: 29
            text: qsTr("c")
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        SpinBox {
            id: spinBoxA
            x: 95
            y: 106
            wrap: true
            editable: true
            to: 1000
            stepSize: 1
        }

        SpinBox {
            id: spinBoxB
            x: 95
            y: 143
            wrap: true
            editable: true
            stepSize: 1
            to: 1000
        }

        SpinBox {
            id: spinBoxC
            x: 95
            y: 179
            wrap: true
            editable: true
            to: 1000
            stepSize: 1
        }

        Button {
            id: buttonCalculate
            x: 9
            y: 215
            width: 206
            height: 32
            text: qsTr("рассчитать")
            font.pointSize: 10
            spacing: 6
            onClicked: task1.calculate()
        }

        TextInput {
            id: textInput3
            x: 9
            y: 253
            width: 80
            height: 30
            text: qsTr("S")
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            readOnly: true
        }

        Text {
            id: textResult
            x: 95
            y: 253
            width: 120
            height: 30
            text: qsTr("результат")
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.capitalization: Font.MixedCase
            style: Text.Normal
        }
    }

    Page{
        id:task2
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
